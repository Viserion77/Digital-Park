import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/bottom_menu_bar.dart';
import 'package:digital_park/screens/map/place_tracker_app.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final Set<Marker> _markers = {};
  GoogleMapController _controler;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => AppState(),
        child: StreamBuilder(
          stream: Firestore.instance.collection('locations').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            snapshot.data.documents.forEach((element) {
              final GeoPoint geoPoint = element.data['wayPoint'];
              _markers.add(Marker(
                markerId: MarkerId(element.documentID),
                position: LatLng(geoPoint.latitude, geoPoint.longitude),
                infoWindow: InfoWindow(
                  title: element.data['description'],
                ),
                icon: BitmapDescriptor.defaultMarker,
                visible: element.data['visible'],
              ));
            });

            return GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.terrain,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: const LatLng(-26.507562218125386, -49.12852719426155),
                zoom: 35.0,
              ),
              onCameraMove: (position) => {
                _controler.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target:
                          const LatLng(-26.507562218125386, -49.12852719426155),
                      zoom: 20,
                    ),
                  ),
                ),
              },
              buildingsEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controler = controller;
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomMenuBar(functionIcon: Icons.search),
    );
  }
}
