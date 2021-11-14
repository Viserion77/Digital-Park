import 'package:digital_park/database/dao/user_settings_dao.dart';
import 'package:digital_park/models/user/user_settings.dart';
import 'package:digital_park/provider/firebase_authentication.dart';
import 'package:digital_park/route_generator.dart';
import 'package:digital_park/theme/app_style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _configureUser();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FirebaseAuthenticationProvider(),
      child: MaterialApp(
        title: 'Digital Park',
        theme: AppStyle().defaultTheme,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

Future<void> _configureUser() async {
  UserSettings userSettings = UserSettings(
    0,
    staySignIn: true,
  );
  try {
    userSettings = await UserSettingsDao().find();
  } catch (error) {
    UserSettingsDao().save(userSettings);
  } finally {
    if (!userSettings.staySignIn) {
      await FirebaseAuthenticationProvider().logout(
        notifyTheListeners: false,
        google: userSettings.provider == 'google',
      );
    }
  }
}
