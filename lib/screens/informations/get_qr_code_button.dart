import 'package:digital_park/components/buttons/fa_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GetQRCode extends StatelessWidget {
  const GetQRCode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FaButton(
      label: 'Achou um código QR, leia-o!',
      onPressed: () {},
      icon: const FaIcon(
        FontAwesomeIcons.qrcode,
        size: 78.0,
      ),
    );
  }
}
