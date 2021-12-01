import 'package:flutter/material.dart';

class DescriptionLines extends StatelessWidget {
  const DescriptionLines(
    this.description, {
    Key? key,
    this.color,
  }) : super(key: key);
  final String description;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...description.split('\\n').map(
          (newPartDescription) {
            final Widget newText = Text(
              newPartDescription.toString(),
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: color ?? Colors.black,
              ),
            );
            return newText;
          },
        ),
      ],
    );
  }
}
