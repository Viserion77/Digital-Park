import 'package:flutter/material.dart';
import 'package:DigitalPark/screens/sign/sign-in.dart';

void main() {
  runApp(ParqueMalweeAPP());
}

class ParqueMalweeAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightGreen,
        accentColor: Colors.lightGreen[600],
        backgroundColor: Colors.grey[50],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.lightGreen,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Login(),
    );
  }
}
