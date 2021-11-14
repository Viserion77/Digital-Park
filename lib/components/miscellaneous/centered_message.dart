import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  final String message;
  final IconData? icon;
  final double? iconSize;
  final double? fontSize;
  final bool loading;

  const CenteredMessage(
    this.message, {
    Key? key,
    this.icon,
    this.iconSize,
    this.fontSize,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 24.0,
            ),
            child: Text(
              message,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
          Visibility(
            child: Icon(
              icon,
              size: iconSize,
            ),
            visible: icon != null,
          ),
          Visibility(
            child: const CircularProgressIndicator(),
            visible: loading,
          ),
        ],
      ),
    );
  }
}
