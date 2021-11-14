import 'package:digital_park/route_generator.dart';
import 'package:flutter/material.dart';

class BottomMenuBar extends StatefulWidget {
  const BottomMenuBar({Key? key}) : super(key: key);

  @override
  _BottomMenuBarState createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.0 * (9.0),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Material(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const Icon(
                  Icons.widgets,
                  size: 36.0,
                ),
              ),
            ),
            Material(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: () => navigatorRoute(context, '/suggestion'),
                child: const Icon(
                  Icons.label,
                  size: 36.0,
                ),
              ),
            ),
            Material(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: () => navigatorRoute(context, '/services'),
                child: const Icon(
                  Icons.attach_money,
                  size: 36.0,
                ),
              ),
            ),
            Material(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: () => navigatorRoute(context, '/user'),
                child: const Icon(
                  Icons.person,
                  size: 36.0,
                ),
              ),
            ),
            const SizedBox(
              width: 36 * 2,
            )
          ],
        ),
      ),
    );
  }
}
