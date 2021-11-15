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
      height: 8.0 * (7.0),
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
                child: const MenuIcon(icon: Icons.widgets),
              ),
            ),
            Material(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: () => navigatorRoute(context, '/suggestion'),
                child: const MenuIcon(icon: Icons.label),
              ),
            ),
            Material(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: () => navigatorRoute(context, '/services'),
                child: const MenuIcon(icon: Icons.attach_money),
              ),
            ),
            Material(
              color: Theme.of(context).primaryColor,
              child: InkWell(
                onTap: () => navigatorRoute(context, '/user'),
                child: const MenuIcon(icon: Icons.person),
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

class MenuIcon extends StatelessWidget {
  const MenuIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Colors.black45,
      size: 29.0,
    );
  }
}
