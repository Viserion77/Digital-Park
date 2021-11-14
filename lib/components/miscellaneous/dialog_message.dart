import 'package:flutter/material.dart';

class DialogMessage extends StatelessWidget {
  final String message;
  final IconData? icon;
  final double? iconSize;
  final double? fontSize;
  final bool loading;

  const DialogMessage(
    this.message, {
    Key? key,
    this.icon,
    this.iconSize,
    this.fontSize,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Visibility(
            child: Icon(
              icon,
              size: iconSize,
            ),
            visible: icon != null,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              message,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ],
      ),
      content: loading ? const CircularProgressIndicator() : null,
    );
  }
}
