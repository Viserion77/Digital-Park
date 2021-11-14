import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:flutter/material.dart';

class EventsList extends StatelessWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultScaffoldApp(
      body: SafeArea(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
