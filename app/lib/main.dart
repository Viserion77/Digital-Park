import 'package:flutter/material.dart';
import 'package:learning/screens/sign/sign-in.dart';

void main() => runApp(ParqueMalweeAPP());

class ParqueMalweeAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lime[700],
        accentColor: Colors.lightGreen[600],
        backgroundColor: Colors.red[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.lightGreen[600],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Login(),
    );
  }
}