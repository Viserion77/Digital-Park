import 'package:digital_park/components/bottom_menu_bar.dart';
import 'package:digital_park/components/side_menu.dart';
import 'package:flutter/material.dart';

class EventsList extends StatelessWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: NavDrawer(),
      bottomNavigationBar: BottomMenuBar(),
      body: SafeArea(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
