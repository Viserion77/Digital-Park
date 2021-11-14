import 'package:flutter/material.dart';

class ContainerBackground extends StatelessWidget {
  const ContainerBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top +
          (8.0 * (9.0)),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'images/background.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
