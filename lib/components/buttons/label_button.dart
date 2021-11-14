import 'package:digital_park/theme/app_style.dart';
import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  const LabelButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.0,
          color: AppStyle().secondaryHeaderColor,
        ),
      ),
    );
  }
}
