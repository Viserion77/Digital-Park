import 'package:digital_park/components/side_menu.dart';
import 'package:digital_park/screens/services/list.dart';
import 'package:digital_park/screens/suggestion/form.dart';
import 'package:digital_park/screens/user/user.dart';
import 'package:flutter/material.dart';

import '../screens/map/map.dart';

class BottomMenuBarExtraInfo extends StatefulWidget {
  final String label;
  final Function function;
  final IconData functionIcon;
  final Widget extraInfo;

  BottomMenuBarExtraInfo({
    this.label,
    this.function,
    this.functionIcon,
    this.extraInfo,
  });

  @override
  _BottomMenuBarExtraInfoState createState() => _BottomMenuBarExtraInfoState();
}

class _BottomMenuBarExtraInfoState extends State<BottomMenuBarExtraInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.0 * (12.0 + (20.0)),
      child: Column(
        children: [
          Container(
            height: 8.0 * 20.0,
            child:
                widget.extraInfo != null ? widget.extraInfo : Text('No info'),
          ),
          Container(
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 10,
                  blurRadius: 7,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
              color: Theme.of(context).primaryColor,
            ),
            height: 8.0 * 12.0,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                    color: Theme.of(context).primaryColor,
                    child: InkWell(
                      onTap: widget.function != null
                          ? widget.function
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => NavDrawer(),
                                ),
                              );
                            },
                      child: Icon(
                        Icons.widgets,
                        size: 36.0,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  ),
                  Material(
                    color: Theme.of(context).primaryColor,
                    child: InkWell(
                      onTap: widget.function != null
                          ? widget.function
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => SuggestionForm()),
                              );
                            },
                      child: Icon(
                        Icons.label,
                        size: 36.0,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  ),
                  Material(
                    color: Theme.of(context).primaryColor,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ServicesList()),
                        );
                      },
                      child: Container(
                        child: Icon(
                          Icons.attach_money,
                          size: 36.0,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Theme.of(context).primaryColor,
                    child: InkWell(
                      onTap: widget.function != null
                          ? widget.function
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Map()),
                              );
                            },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        transform: Matrix4.translationValues(0.0, -18.0, 0.0),
                        decoration: new BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).secondaryHeaderColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Icon(
                          widget.functionIcon != null
                              ? widget.functionIcon
                              : Icons.map,
                          size: 64.0,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Theme.of(context).primaryColor,
                    child: InkWell(
                      onTap: widget.function != null
                          ? widget.function
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => UserPage()),
                              );
                            },
                      child: Icon(
                        Icons.person,
                        size: 36.0,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomMenuBar extends StatefulWidget {
  final String label;
  final Function function;
  final IconData functionIcon;

  BottomMenuBar({
    this.label,
    this.function,
    this.functionIcon,
  });

  @override
  _BottomMenuBarState createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.0 * (12.0),
      child: Container(
        color: Theme.of(context).primaryColor,
        height: 8.0 * 12.0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NavDrawer(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.widgets,
                    size: 36.0,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
              Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SuggestionForm(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.label,
                    size: 36.0,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
              Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ServicesList()),
                    );
                  },
                  child: Container(
                    child: Icon(
                      Icons.attach_money,
                      size: 36.0,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ),
              ),
              Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: widget.function != null
                      ? widget.function
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
                      widget.functionIcon != null
                          ? widget.functionIcon
                          : Icons.map,
                      size: 64.0,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ),
              ),
              Material(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserPage()),
                    );
                  },
                  child: Icon(
                    Icons.person,
                    size: 36.0,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
