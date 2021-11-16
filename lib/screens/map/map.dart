import 'package:digital_park/components/bottom_menu_bar.dart';
import 'package:digital_park/components/side_menu.dart';
import 'package:digital_park/models/user/user_profile.dart';
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
  late GoogleMapController _controller;
  final Location _location = Location();
  late bool userOutRange = false;
  void _verifyUserOutRange(position) {
    if (position.target.longitude < -49.13593780249357 ||
        position.target.longitude > -49.11852154880762 &&
            position.target.latitude > -26.497728001569904 ||
        position.target.latitude < -26.510341665930866) {
      if (!userOutRange) {
        setState(() {
          userOutRange = true;
        });
      }
    } else {
      if (userOutRange) {
        setState(() {
          userOutRange = false;
        });
      }
    }
  }

  void _onMapCreated(GoogleMapController controllerMap) {
    _controller = controllerMap;
  }

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
        floatingActionButton: Container(
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
                onPressed: () {
                  if (userOutRange) {
                    _controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        const CameraPosition(
                          target:
                              LatLng(-26.50792825460458, -49.12902072072029),
                          zoom: 20.0,
                          bearing: 50,
                          tilt: 70,
                        ),
                      ),
                    );
                  } else {}
                },
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
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 3.5,
          child: BottomMenuBar(
            userProfile: widget.userProfile,
          ),
          elevation: 3.0,
        ),
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: GoogleMap(
            mapType: MapType.terrain,
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
          ),
        ),
      ),
    );
  }
}
