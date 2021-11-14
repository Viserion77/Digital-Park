import 'package:digital_park/components/buttons/background_button.dart';
import 'package:flutter/material.dart';

class GenerateActivity extends StatelessWidget {
  const GenerateActivity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundButton(
      label: 'Uma atividade para agora?',
      onPressed: () {},
    );
  }
}
