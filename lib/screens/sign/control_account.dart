import 'package:digital_park/components/buttons/label_button.dart';
import 'package:digital_park/components/inputs/label_box.dart';
import 'package:digital_park/database/dao/user_settings_dao.dart';
import 'package:digital_park/models/user/user_settings.dart';
import 'package:digital_park/screens/sign/password_reset_dialog.dart';
import 'package:flutter/material.dart';

class ControllerAccount extends StatefulWidget {
  const ControllerAccount({
    Key? key,
    required this.userSettings,
    this.whenUpdate,
  }) : super(key: key);

  final UserSettings userSettings;
  final Function? whenUpdate;

  @override
  State<ControllerAccount> createState() => _ControllerAccountState();
}

class _ControllerAccountState extends State<ControllerAccount> {
  late bool staySignIn = widget.userSettings.staySignIn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LabelBox(
          label: 'Permanecer Conectado',
          value: staySignIn,
          function: updateSignOption,
        ),
        LabelButton(
          label: 'Esqueceu a senha?',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const PasswordResetDialog(),
            );
          },
        ),
      ],
    );
  }

  updateSignOption() async {
    setState(() {
      staySignIn = !staySignIn;
      if (widget.whenUpdate != null) widget.whenUpdate!();
    });

    final UserSettings userSettings = widget.userSettings;
    userSettings.staySignIn = staySignIn;
    await UserSettingsDao().update(userSettings);
  }
}
