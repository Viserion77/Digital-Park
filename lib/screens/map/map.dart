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
  Set<Marker> _markers = {};
  bool returnig = false;
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

            _markers = {};
            snapshot.data.documents.forEach((element) {
              final GeoPoint geoPoint = element.data['wayPoint'];
              print(element.data);
              _markers.add(
                Marker(
                  markerId: MarkerId(element.documentID),
                  position: LatLng(geoPoint.latitude, geoPoint.longitude),
                  infoWindow: InfoWindow(
                    title: element.data['description'],
                  ),
                  icon: BitmapDescriptor.defaultMarker,
                  visible: element.data['visible'],
                ),
              );
            });

            return GoogleMap(
              mapType: MapType.terrain,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: const LatLng(-26.507562218125386, -49.12852719426155),
                zoom: 35.0,
              ),
              onCameraMove: (position) => {
                if (position.target.longitude > -49.13593780249357 ||
                    position.target.longitude < -49.120618030428886 &&
                        position.target.latitude < -26.497728001569904 ||
                    position.target.latitude > -26.510341665930866)
                  {
                    returnig = false,
                  },
                if (position.target.longitude < -49.13593780249357 ||
                    position.target.longitude > -49.120618030428886 &&
                        position.target.latitude > -26.497728001569904 ||
                    position.target.latitude < -26.510341665930866)
                  {
                    returnig = true,
                    _controler.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          tilt: 70,
                          target: const LatLng(
                              -26.507562218125386, -49.12852719426155),
                          zoom: 20,
                        ),
                      ),
                    )
                  }
              },
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controler = controller;
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomMenuBar(
        extraInfo: Text('Oxi'),
      ),
    );
  }
}
