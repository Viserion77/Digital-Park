import 'package:digital_park/components/buttons/background_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FaButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final FaIcon icon;
  final bool onLoading;
  final Color? color;
  final Color? fontColor;

  const FaButton({
    Key? key,
    this.label = '',
    required this.onPressed,
    required this.icon,
    this.onLoading = false,
    this.color,
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onLoading
        ? BackgroundButton(
            label: label,
            onPressed: onPressed,
            onLoading: onLoading,
          )
        : ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: color ?? Theme.of(context).primaryColor,
              onPrimary: fontColor ?? Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              minimumSize: const Size(double.infinity, 40.0),
            ),
            icon: icon,
            onPressed: () {
              onPressed();
            },
            label: Text(
              label,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          );
  }
}
