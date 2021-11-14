import 'package:digital_park/components/buttons/label_button.dart';
import 'package:digital_park/components/inputs/text_input.dart';
import 'package:digital_park/provider/firebase_authentication.dart';
import 'package:flutter/material.dart';

class PasswordResetDialog extends StatefulWidget {
  const PasswordResetDialog({Key? key}) : super(key: key);

  @override
  State<PasswordResetDialog> createState() => _PasswordResetDialogState();
}

class _PasswordResetDialogState extends State<PasswordResetDialog> {
  final TextEditingController _controllerEmail = TextEditingController();

  String _errorEmail = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Recuperação de senha'),
      content: TextInput(
        controller: _controllerEmail,
        errorText: _errorEmail,
        label: 'E-mail',
      ),
      actions: [
        LabelButton(
          label: 'Cancelar',
          onPressed: () => Navigator.pop(context),
        ),
        LabelButton(
          label: 'Confirmar',
          onPressed: () async {
            if (_controllerEmail.text.isEmpty) {
              setState(() {
                _errorEmail = 'Insira um e-mail valido!';
              });
            } else {
              await FirebaseAuthenticationProvider().passwordResetStandard(
                email: _controllerEmail.text,
              );
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
