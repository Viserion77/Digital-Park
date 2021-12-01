import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/container_background.dart';
import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:digital_park/components/status_message.dart';
import 'package:digital_park/models/user/user_profile.dart';
import 'package:digital_park/screens/events/next_event_card.dart';
import 'package:digital_park/screens/informations/get_qr_code_button.dart';
import 'package:digital_park/screens/informations/home_header_informations.dart';
import 'package:digital_park/screens/seggestions/generate_activit_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!.providerData.isNotEmpty
        ? const HomeWithProfile()
        : const HomeAnonymously();
  }
}

class HomeAnonymously extends StatelessWidget {
  const HomeAnonymously({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProfile userProfile = UserProfile.fromCurrentUser();
    return DefaultScaffoldApp(
      userProfile: userProfile,
      body: ContainerBackground(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(32.0),
          children: [
            HomeHeaderInformations(
              userProfile: userProfile,
            ),
            const SizedBox(height: 16),
            NextEventCard(
              userProfile: userProfile,
            ),
            const SizedBox(height: 16),
            GenerateSuggestion(
              userProfile: userProfile,
            ),
            const SizedBox(height: 16),
            GetQRCode(userProfile: userProfile),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class HomeWithProfile extends StatelessWidget {
  const HomeWithProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const StatusMessage(
            errorMessage: 'Algo deu errado, sem conexão!',
            errorIcon: Icons.warning,
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const StatusMessage(
            errorMessage: 'Digital Park',
            loading: true,
          );
        } else if (snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError || !snapshot.hasData) {
            return const StatusMessage(
              errorMessage: 'Algo deu errado, erro na autenticação!',
              errorIcon: Icons.warning,
            );
          } else {
            if (!snapshot.data!.exists) {
              saveUserNewProfile();
              return const StatusMessage(
                errorMessage: 'Digital Park',
                loading: true,
              );
            } else {
              final UserProfile userProfile =
                  UserProfile.fromSnapshot(snapshot.data);
              if (userProfile.active == null || userProfile.active != false) {
                return DefaultScaffoldApp(
                  userProfile: userProfile,
                  body: ContainerBackground(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(32.0),
                      children: [
                        HomeHeaderInformations(
                          userProfile: userProfile,
                        ),
                        NextEventCard(
                          userProfile: userProfile,
                        ),
                        GenerateSuggestion(
                          userProfile: userProfile,
                        ),
                        GetQRCode(userProfile: userProfile),
                      ],
                    ),
                  ),
                );
              }
            }
          }
        }
        return const StatusMessage(
          errorMessage: 'Algo deu errado!',
          errorIcon: Icons.warning,
        );
      },
    );
  }

  void saveUserNewProfile() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set(UserProfile.fromCurrentUser().toJson());
  }
}
