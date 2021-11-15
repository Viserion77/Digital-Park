import 'package:digital_park/theme/app_style.dart';
import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  final String label;
  final TextAlign? textAlign;
  final Function onPressed;
  final double? fontSize;
  final Color? textColor;

  LabelButton({
    Key? key,
    required this.label,
    this.textAlign,
    this.fontSize,
    this.textColor,
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
        textAlign: textAlign ?? TextAlign.left,
        style: TextStyle(
          fontSize: fontSize ?? 12.0,
          color: textColor ?? AppStyle().secondaryHeaderColor,
        ),
      ),
    );
  }
}
