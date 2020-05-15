

import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset('images/logo.png'),
          ),
          Container(
            height: 120,
            width: 100,
            color: Theme.of(context).primaryColor,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.people,
                  color: Colors.white,
                  size: 32,
                ),
                Text(
                  'teste',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}