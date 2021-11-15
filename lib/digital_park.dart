import 'package:digital_park/components/status_message.dart';
import 'package:digital_park/screens/home.dart';
import 'package:digital_park/screens/sign/login_screen.dart';
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
          if (snapshot.hasError) {
            return const StatusMessage(
              errorMessage: 'Algo deu errado, erro na autenticação!',
              errorIcon: Icons.warning,
            );
          } else if (snapshot.hasData) {
            return const Home();
          } else {
            return const LoginScreen();
          }
        }
        return const StatusMessage(
          errorMessage: 'Algo deu errado!',
          errorIcon: Icons.warning,
        );
      },
    );
  }
}
