import 'package:digital_park/components/buttons/fa_button.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:digital_park/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GetQRCode extends StatelessWidget {
  const GetQRCode({
    Key? key,
    required this.userProfile,
  }) : super(key: key);
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return FaButton(
      label: 'Achou um código QR, leia-o!',
      onPressed: () {
        navigatorRoute(context, '/qr-code-scan-page', arguments: userProfile);
      },
      icon: const FaIcon(
        FontAwesomeIcons.qrcode,
        size: 78.0,
      ),
    );
  }
}
