import 'package:DigitalPark/components/side_menu.dart';
import 'package:flutter/material.dart';

import '../screens/map/map.dart';

class BottomMenuBar extends StatelessWidget {
  final String label;
  final Function function;
  final IconData functionIcon;

  BottomMenuBar({
    this.label,
    this.function,
    this.functionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: function != null
                      ? function
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => NavDrawer()),
                          );
                        },
                  child: Icon(
                    Icons.widgets,
                    size: 36.0,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
              Icon(
                Icons.label,
                size: 36.0,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              Icon(
                Icons.attach_money,
                size: 36.0,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: function != null
                      ? function
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Map()),
                          );
                        },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    transform: Matrix4.translationValues(0.0, -36.0, 0.0),
                    decoration: new BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).secondaryHeaderColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Icon(
                      functionIcon != null ? functionIcon : Icons.map,
                      size: 64.0,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.person,
                size: 36.0,
                color: Theme.of(context).secondaryHeaderColor,
              )
            ],
          ),
        ));
  }
}
