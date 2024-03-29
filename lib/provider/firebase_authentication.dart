import 'package:digital_park/database/dao/user_settings_dao.dart';
import 'package:digital_park/models/user_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthenticationProvider extends ChangeNotifier {
  Future logout({
    bool notifyTheListeners = true,
  }) async {
    try {
      if (FirebaseAuth.instance.currentUser!.providerData.isNotEmpty &&
          FirebaseAuth.instance.currentUser!.providerData[0].providerId ==
              'google.com') {
        await GoogleSignIn().disconnect();
      }
    } catch (error) {
      print('Error to disconect google: $error');
    }
    await FirebaseAuth.instance.signOut();
    await _updateUserSettings(null);

    if (notifyTheListeners) {
      notifyListeners();
    }
  }

  Future loginWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    await _updateUserSettings('google');

    notifyListeners();
  }

  Future signInStandard({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _updateUserSettings('standard');

    notifyListeners();
  }

  Future signUpStandard({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _updateUserSettings('standard');

    notifyListeners();
  }

  Future loginAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
    await _updateUserSettings('anonymously');

    notifyListeners();
  }

  Future passwordResetStandard({
    required String email,
  }) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    );
  }

  Future resetPasswordResetStandard({
    required String code,
    required String newPassword,
  }) async {
    await FirebaseAuth.instance.confirmPasswordReset(
      newPassword: newPassword,
      code: code,
    );
  }

  Future<void> _updateUserSettings(String? provider) async {
    final UserSettings userSettings = await UserSettingsDao().find();
    userSettings.provider = provider;
    await UserSettingsDao().update(userSettings);
  }
}
