import 'package:DigitalPark/components/bottomMenuBar.dart';
import 'package:DigitalPark/screens/map/place_tracker_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => AppState(),
        child: PlaceTrackerApp(),
      ),
      bottomNavigationBar: BottomMenuBar(functionIcon: Icons.search),
    );
  }
}
