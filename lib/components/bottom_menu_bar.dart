import 'package:digital_park/screens/map/map.dart';
import 'package:digital_park/screens/seggestions/suggestion_home.dart';
import 'package:digital_park/screens/services/list.dart';
import 'package:digital_park/screens/user/user.dart';
import 'package:flutter/material.dart';

class BottomMenuBar extends StatefulWidget {
  const BottomMenuBar({Key? key}) : super(key: key);

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
                    Scaffold.of(context).openDrawer();
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
                      MaterialPageRoute(builder: (context) => SuggestionHome()),
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
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MapScreen()),
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
                      Icons.map,
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
