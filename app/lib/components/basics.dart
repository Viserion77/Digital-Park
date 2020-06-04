import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String tip;
  final IconData icon;
  final TextInputType keyboardType;

  Input({this.controller, this.label, this.tip, this.icon, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: tip,
        ),
        style: TextStyle(
          fontSize: 24,
        ),
        keyboardType: keyboardType != null ? keyboardType : TextInputType.text,
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onPressed;

  Button({this.label, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: RaisedButton(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon),
              Text(
                label != null ? label : null,
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
            ],
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class TextFunction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;

  TextFunction({this.label, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon),
              Text(
                label,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JustImage extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;

  JustImage({this.label, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        child: Image(),
      ),
    );
  }
}
