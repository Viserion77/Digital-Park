import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/bottom_menu_bar.dart';
import 'package:digital_park/models/wayPiont.dart';
import 'package:digital_park/screens/map/place_tracker_app.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'WayPoint.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Set<Marker> _markers = {};
  bool returnig = false;
  bool showExtraInfo = false;
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
            var myIcon;
            BitmapDescriptor.fromAssetImage(
                    ImageConfiguration(size: Size(4, 4)), 'images/logo.png')
                .then((onValue) {
              myIcon = onValue;
            });

            snapshot.data.documents.forEach((element) {
              final geoPoint = element.data['wayPoint'];
              final WayPoint wayPoint = new WayPoint(
                  element.documentID,
                  element.data['name'],
                  element.data['description'],
                  element.data['image']);
              _markers.add(
                Marker(
                  markerId: MarkerId(element.documentID),
                  position: LatLng(geoPoint['_lat'], geoPoint['_long']),
                  infoWindow: InfoWindow(
                    title: element.data['name'],
                  ),
                  icon: myIcon,
                  visible: element.data['visible'],
                  onTap: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WayPointPlace(wayPoint: wayPoint),
                      ),
                    )
                  },
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
                    position.target.longitude < -49.11852154880762 &&
                        position.target.latitude < -26.497728001569904 ||
                    position.target.latitude > -26.510341665930866)
                  {
                    returnig = false,
                  },
                if (position.target.longitude < -49.13593780249357 ||
                    position.target.longitude > -49.11852154880762 &&
                        position.target.latitude > -26.497728001569904 ||
                    position.target.latitude < -26.510341665930866)
                  {
                    returnig = true,
                    _controler.moveCamera(
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
      bottomNavigationBar: ChangeNotifierProvider(
        create: (context) => AppState(),
        child: StreamBuilder(
          stream: Firestore.instance.collection('temporary_test').snapshots(),
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

            showExtraInfo = false;
            snapshot.data.documents.forEach((element) {
              if (element.documentID == 'maps_filter_options') {
                showExtraInfo = element.data['show_filters'];
              }
            });

            return showExtraInfo == false
                ? BottomMenuBar(
                    functionIcon: Icons.search,
                    function: () => Firestore.instance
                        .collection('temporary_test')
                        .document('maps_filter_options')
                        .updateData({'show_filters': true}),
                  )
                : BottomMenuBarExtraInfo(
                    functionIcon: Icons.search,
                    function: () => Firestore.instance
                        .collection('temporary_test')
                        .document('maps_filter_options')
                        .updateData({'show_filters': false}),
                    extraInfo: Column(
                      children: [
                        Container(
                          height: 3.0,
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Container(
                          height: 8.0 * 20.0 - 3.0,
                          color: Theme.of(context).primaryColor,
                          child: SingleChildScrollView(
                            child: ChangeNotifierProvider(
                              create: (context) => AppState(),
                              child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection('tags')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  var columnOfRows = [];
                                  List<Widget> rowPack = [];
                                  List<Widget> filterColumn = [];
                                  var countPack = 0;
                                  snapshot.data.documents.forEach((element) {
                                    rowPack.add(
                                      FilterIcon(
                                        onTap: () {
                                          Firestore.instance
                                              .collection('temporary_test')
                                              .document('maps_filter_options')
                                              .updateData({
                                            'filterTags':
                                                FieldValue.arrayUnion([
                                              Firestore.instance
                                                  .collection('tags')
                                                  .document(element.documentID)
                                            ])
                                          });
                                        },
                                        name: element['name'] != null
                                            ? element['name']
                                            : element.documentID,
                                        tagIcon: element['icon'] != null
                                            ? IconData(
                                                element['icon']['codePoint'],
                                                fontFamily: element['icon']
                                                    ['fontFamily'],
                                              )
                                            : Icons.error,
                                        selected: false,
                                      ),
                                    );
                                    countPack += 1;
                                    if (countPack == 5) {
                                      countPack = 0;
                                      columnOfRows.add(rowPack);
                                      filterColumn.add(Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: rowPack,
                                      ));
                                      rowPack = [];
                                    }
                                  });
                                  filterColumn.add(Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: rowPack,
                                  ));

                                  return Column(children: filterColumn);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class FilterIcon extends StatelessWidget {
  final String name;
  final IconData tagIcon;
  final Function onTap;
  final bool selected;
  const FilterIcon({
    Key key,
    this.name,
    this.tagIcon,
    this.onTap,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 70.0,
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: selected
                          ? Theme.of(context).secondaryHeaderColor
                          : null),
                ),
              ),
            ),
          ),
          Icon(
            tagIcon,
            size: 56.0,
            color: selected ? Theme.of(context).secondaryHeaderColor : null,
          ),
        ],
      ),
    );
  }
}
