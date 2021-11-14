import 'package:digital_park/components/miscellaneous/centered_message.dart';
import 'package:digital_park/screens/home.dart';
import 'package:digital_park/screens/sign/screen_changer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DigitalPark extends StatelessWidget {
  const DigitalPark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Scaffold(
            body: SafeArea(
              child: CenteredMessage(
                'Algo deu errado, sem conexão!',
                icon: Icons.warning,
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: SafeArea(
              child: CenteredMessage(
                'Digital Park',
                loading: true,
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return const Scaffold(
              body: SafeArea(
                child: CenteredMessage(
                  'Algo deu errado, erro na autenticação!',
                  icon: Icons.warning,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return const Home();
          } else {
            return const ScreenChanger();
          }
        }
        return const Scaffold(
          body: SafeArea(
            child: CenteredMessage(
              'Algo deu errado!',
              icon: Icons.warning,
            ),
          ),
        );
      },
    );
  }
}
