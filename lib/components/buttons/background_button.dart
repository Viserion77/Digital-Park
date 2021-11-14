import 'package:flutter/material.dart';

class BackgroundButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final bool onLoading;

  const BackgroundButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.onLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.lightGreen,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        minimumSize: const Size(double.infinity, 40.0),
      ),
      onPressed: !onLoading
          ? () {
              onPressed();
            }
          : null,
      child: !onLoading
          ? Text(
              label,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            )
          : const SizedBox(
              height: 16.0,
              width: 16.0,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
              ),
            ),
    );
  }
}
