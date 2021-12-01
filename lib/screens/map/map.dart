import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/bottom_menu_bar.dart';
import 'package:digital_park/components/side_menu.dart';
import 'package:digital_park/models/locations/location_waypoint.dart';
import 'package:digital_park/models/tags/tag.dart';
import 'package:digital_park/models/user/user_profile.dart';
import 'package:digital_park/screens/map/location_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
    required this.userProfile,
  }) : super(key: key);
  final UserProfile userProfile;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController? _controller = null;
  final Location _location = Location();
  late bool userOutRange = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //i like transaparent :-)
        systemNavigationBarColor:
            Theme.of(context).secondaryHeaderColor, // navigation bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness:
            Brightness.dark, //navigation bar icons' color
      ),
      child: Scaffold(
        drawer: NavDrawer(
          userProfile: widget.userProfile,
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: userOutRange
            ? FloatingActionButtonLocation.miniEndDocked
            : FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButtonMap(
          userOutRange: userOutRange,
          controller: _controller,
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 3.5,
          child: BottomMenuBar(
            userProfile: widget.userProfile,
          ),
          elevation: 3.0,
        ),
        extendBody: true,
        body: MapScreenController(
          userProfile: widget.userProfile,
          onMapCreated: (GoogleMapController controllerMap) {
            _controller = controllerMap;
          },
          controller: _controller,
          onUserOutRange: (bool isTrue) {
            if (userOutRange != isTrue) {
              setState(() {
                userOutRange = isTrue;
              });
            }
          },
        ),
      ),
    );
  }
}

class MapScreenController extends StatelessWidget {
  const MapScreenController({
    Key? key,
    required GoogleMapController? controller,
    required Function(GoogleMapController controllerMap) onMapCreated,
    required Function(bool isTrue) onUserOutRange,
    required UserProfile userProfile,
  })  : _controller = controller,
        _onMapCreated = onMapCreated,
        _onUserOutRange = onUserOutRange,
        _userProfile = userProfile,
        super(key: key);

  final GoogleMapController? _controller;
  final Function(GoogleMapController controllerMap) _onMapCreated;
  final Function(bool isTrue) _onUserOutRange;
  final UserProfile _userProfile;

  void _verifyUserOutRange(position) {
    if (position.target.longitude < -49.13593780249357 ||
        position.target.longitude > -49.11852154880762 &&
            position.target.latitude > -26.497728001569904 ||
        position.target.latitude < -26.510341665930866) {
      _onUserOutRange(true);
    } else {
      _onUserOutRange(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Tag> tagsFilter;
    return SafeArea(
      bottom: false,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('locations')
              .where('visible', isNotEqualTo: false)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            final Set<Marker> locations = {};
            if (snapshot.hasData) {
              locations.addAll(
                snapshot.data!.docs.map(
                  (e) {
                    final LocationWaypoint locationWaypoint =
                        LocationWaypoint.fromSnapshot(e);
                    return Marker(
                      markerId: MarkerId(locationWaypoint.id),
                      position: LatLng(
                        locationWaypoint.wayPoint!.latitude,
                        locationWaypoint.wayPoint!.longitude,
                      ),
                      infoWindow: InfoWindow(title: locationWaypoint.name),
                      visible: locationWaypoint.visible ?? false,
                      onTap: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LocationDetail(
                              userProfile: _userProfile,
                              locationWaypoint: locationWaypoint,
                            ),
                          ),
                        )
                      },
                    );
                  },
                ),
              );
            }
            return GoogleMap(
              mapType: MapType.terrain,
              markers: locations,
              padding: const EdgeInsets.only(bottom: 8.0),
              minMaxZoomPreference: const MinMaxZoomPreference(17, 30),
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              mapToolbarEnabled: false,
              onMapCreated: _onMapCreated,
              myLocationButtonEnabled: true,
              initialCameraPosition: const CameraPosition(
                target: LatLng(
                  -26.50792825460458,
                  -49.12902072072029,
                ),
                zoom: 20.0,
                bearing: 50,
                tilt: 70,
              ),
              onCameraMove: (position) {
                _verifyUserOutRange(position);
                print(position.target.toString());
              },
            );
          }),
    );
  }
}

class FloatingActionButtonMap extends StatelessWidget {
  const FloatingActionButtonMap({
    Key? key,
    required this.userOutRange,
    required GoogleMapController? controller,
  })  : _controller = controller,
        super(key: key);

  final bool userOutRange;
  final GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 1.5,
            blurRadius: 1.5,
            offset: Offset(0.5, 0.5),
          ),
        ],
      ),
      child: SizedBox(
        width: 85,
        height: 85,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () => actionMapController(context),
            child: userOutRange
                ? const FaIcon(
                    FontAwesomeIcons.undo,
                    color: Colors.deepOrange,
                  )
                : const Icon(
                    Icons.search,
                    size: 35.0,
                  ),
          ),
        ),
      ),
    );
  }

  void actionMapController(BuildContext context) {
    if (userOutRange) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          const CameraPosition(
            target: LatLng(-26.50792825460458, -49.12902072072029),
            zoom: 20.0,
            bearing: 50,
            tilt: 70,
          ),
        ),
      );
    } else {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return const TagsFilterSheet();
        },
      );
    }
  }
}

class TagsFilterSheet extends StatelessWidget {
  const TagsFilterSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 216,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: Text(
                  'Filtrar',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('tags').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                final List<Tag> tags = [];
                if (snapshot.hasData) {
                  tags.addAll(snapshot.data!.docs.map(
                    (snapshotTag) => Tag.fromSnapshot(snapshotTag),
                  ));
                }
                return SizedBox(
                  height: 160,
                  child: GridView.count(
                    childAspectRatio: (30 / 10),
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    children: [
                      ...tags.map(
                        (tag) => TagMarkerFilter(tag: tag),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class TagMarkerFilter extends StatefulWidget {
  const TagMarkerFilter({
    Key? key,
    required this.tag,
  }) : super(key: key);
  final Tag? tag;

  @override
  State<TagMarkerFilter> createState() => _TagMarkerFilterState();
}

class _TagMarkerFilterState extends State<TagMarkerFilter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Checkbox(
                value: widget.tag!.tagSelected || false,
                onChanged: (bool? value) {
                  setState(() {
                    widget.tag!.tagSelected = value!;
                  });
                },
              ),
              const SizedBox(
                width: 4,
              ),
              Text(widget.tag!.id),
            ],
          ),
        ),
      ),
    );
  }
}
