import 'package:DigitalPark/components/bottomMenuBar.dart';
import 'package:DigitalPark/screens/map/place_tracker_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final Set<Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    _markers.add(Marker(
      markerId: MarkerId("1"),
      position: LatLng(-26.507562218125386, -49.12852719426155),
      infoWindow: InfoWindow(
        title: "teste 1",
      ),
      icon: BitmapDescriptor.defaultMarker,
      visible: true,
    ));
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => AppState(),
        child: GoogleMap(
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target: const LatLng(-26.507562218125386, -49.12852719426155),
            zoom: 11.0,
          ),
        ),
      ),
      bottomNavigationBar: BottomMenuBar(functionIcon: Icons.search),
    );
  }
}
