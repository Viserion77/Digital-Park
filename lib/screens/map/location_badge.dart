import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/models/location_waypoint.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:digital_park/screens/map/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationBadge extends StatefulWidget {
  const LocationBadge({
    Key? key,
    required this.location,
    required this.userProfile,
  }) : super(key: key);

  final DocumentReference location;
  final UserProfile userProfile;
  @override
  _LocationBadgeState createState() => _LocationBadgeState();
}

class _LocationBadgeState extends State<LocationBadge> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.location.snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            final LocationWaypoint locationWaypoint =
                LocationWaypoint.fromSnapshot(
              snapshot.data,
            );
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        userProfile: widget.userProfile,
                        startMapAt: LatLng(
                          locationWaypoint.wayPoint!.latitude,
                          locationWaypoint.wayPoint!.longitude,
                        ),
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        const Icon(Icons.map),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          locationWaypoint.name.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
