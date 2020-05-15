import 'package:flutter/material.dart';
import 'package:learning/screens/sign/sign-in.dart';

void main() => runApp(ParqueMalweeAPP());

class ParqueMalweeAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red[900],
        accentColor: Colors.orange[700],
        backgroundColor: Colors.green[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.pink[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Login(),
    );
  }
}