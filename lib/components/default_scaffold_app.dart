import 'package:digital_park/components/bottom_menu_bar.dart';
import 'package:digital_park/components/side_menu.dart';
import 'package:digital_park/models/user/user_profile.dart';
import 'package:digital_park/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultScaffoldApp extends StatelessWidget {
  const DefaultScaffoldApp({
    Key? key,
    required this.body,
    required this.userProfile,
  }) : super(key: key);

  final Widget body;
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //i like transaparent :-)
        systemNavigationBarColor:
            Theme.of(context).secondaryHeaderColor, // navigation bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness:
            Brightness.dark, //navigation bar icons' color
      ),
      child: Scaffold(
        drawer: NavDrawer(
          userProfile: userProfile,
        ),
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
          child: SizedBox(
            width: 85,
            height: 85,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () => navigatorRoute(
                  context,
                  '/map',
                  arguments: userProfile,
                ),
                child: const Icon(
                  Icons.map,
                  size: 35.0,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 3.5,
          child: BottomMenuBar(
            userProfile: userProfile,
          ),
          elevation: 3.0,
        ),
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: body,
        ),
      ),
    );
  }
}
