import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:flutter/material.dart';

class SuggestionHome extends StatelessWidget {
  const SuggestionHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultScaffoldApp(
      body: SafeArea(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
