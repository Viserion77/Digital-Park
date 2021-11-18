import 'package:flutter/material.dart';

class DescriptionLines extends StatelessWidget {
  const DescriptionLines(
    this.description, {
    Key? key,
  }) : super(key: key);
  final String description;

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
              style: const TextStyle(
                fontSize: 16.0,
              ),
            );
            return newText;
          },
        ),
      ],
    );
  }
}
