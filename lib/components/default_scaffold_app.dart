import 'package:digital_park/components/bottom_menu_bar.dart';
import 'package:digital_park/components/side_menu.dart';
import 'package:digital_park/route_generator.dart';
import 'package:flutter/material.dart';

class DefaultScaffoldApp extends StatelessWidget {
  const DefaultScaffoldApp({
    Key? key,
    required this.body,
  }) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1.5,
              blurRadius: 1.5,
              offset: Offset(0.5, 0.5),
            ),
          ],
        ),
        child: FloatingActionButton.large(
          onPressed: () => navigatorRoute(context, '/map'),
          child: const Icon(
            Icons.map,
            size: 64.0,
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        notchMargin: 3.5,
        child: BottomMenuBar(),
        elevation: 3.0,
      ),
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: body,
      ),
    );
  }
}
