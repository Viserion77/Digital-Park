import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  final String message;
  final IconData? icon;
  final double iconSize;
  final double fontSize;
  final bool loading;
  final List<Widget> children;

  const CenteredMessage(
    this.message, {
    Key? key,
    this.icon,
    this.iconSize = 56.0,
    this.fontSize = 40.0,
    this.loading = false,
    this.children = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(
              32.0,
            ),
            child: Text(
              message,
              style: TextStyle(
                fontSize: fontSize,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Visibility(
            child: Icon(
              icon,
              size: iconSize,
              color: Theme.of(context).primaryColor,
            ),
            visible: icon != null,
          ),
          Visibility(
            child: const CircularProgressIndicator(),
            visible: loading,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [...children],
            ),
          )
        ],
      ),
    );
  }
}
