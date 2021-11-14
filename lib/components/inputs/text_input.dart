import 'package:digital_park/theme/app_style.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String tip;
  final double fontSize;
  final String errorText;
  final TextInputType keyboardType;
  final bool obscureText;

  const TextInput({
    Key? key,
    required this.controller,
    this.label = '',
    this.tip = '',
    this.fontSize = 16.0,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.errorText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: tip,
        errorText: errorText == '' ? null : errorText,
      ),
      cursorColor: AppStyle().primaryColor,
      style: TextStyle(
        color: AppStyle().primaryColor,
        fontSize: fontSize,
        decorationColor: AppStyle().primaryColor,
      ),
    );
  }
}
