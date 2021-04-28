import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              'images/logo.png',
              width: 40,
            ),
          ),
        ),
      ),
      body: Text('User'),
    );
  }
}
