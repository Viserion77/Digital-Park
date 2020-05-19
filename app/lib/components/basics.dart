import 'dart:async';

import 'package:flutter/material.dart';

class Imput extends StatelessWidget {
  final TextEditingController _campo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: TextField(
        controller: _campo,
        decoration: InputDecoration(labelText: 'Apelido'),
        style: TextStyle(fontSize: 24),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
