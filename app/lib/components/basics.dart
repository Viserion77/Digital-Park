import 'dart:async';

import 'package:flutter/material.dart';

class Imput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String tip;
  final IconData icon;
  final TextInputType keyboardType;

  Imput({this.controller, this.label, this.tip, this.icon, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: TextField(
        controller: controller != null ? controller : null,
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label != null ? label : null,
          hintText: tip != null ? tip : null,
        ),
        style: TextStyle(
          fontSize: 24,
        ),
        keyboardType: keyboardType != null ? keyboardType : TextInputType.text,
      ),
    );
  }
}
