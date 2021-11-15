import 'package:digital_park/components/buttons/background_button.dart';
import 'package:digital_park/components/status_message.dart';
import 'package:digital_park/provider/firebase_authentication.dart';
import 'package:flutter/material.dart';

class BackAndSignIn extends StatelessWidget {
  const BackAndSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatusMessage(
      errorMessage:
          'Para acessar este contudo você precisa realizar login no sistema!',
      children: [
        BackgroundButton(
          label: 'Voltar',
          onPressed: () => Navigator.of(context).pop(),
        ),
        BackgroundButton(
          label: 'Realizar login',
          onPressed: () {
            FirebaseAuthenticationProvider().logout();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
