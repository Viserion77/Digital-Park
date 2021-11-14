import 'package:digital_park/components/buttons/label_button.dart';
import 'package:digital_park/theme/app_style.dart';
import 'package:flutter/material.dart';

class LabelBox extends StatelessWidget {
  final String label;
  final Function function;
  final bool value;

  const LabelBox({
    Key? key,
    this.label = '',
    required this.function,
    this.value = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (value) => function(),
          checkColor: Colors.white,
          activeColor: AppStyle().secondaryHeaderColor,
        ),
        LabelButton(
          label: label,
          onPressed: () => function(),
        )
      ],
    );
  }
}
