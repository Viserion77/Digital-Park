import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/description_lines.dart';
import 'package:digital_park/components/sheet_information_scaffold.dart';
import 'package:digital_park/models/activities.dart';
import 'package:digital_park/models/location_waypoint.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:digital_park/screens/map/location_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityDetail extends StatefulWidget {
  const ActivityDetail({
    Key? key,
    required this.userProfile,
    required this.parkActivity,
  }) : super(key: key);
  final UserProfile userProfile;
  final ParkActivity parkActivity;

  @override
  State<ActivityDetail> createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {
  @override
  Widget build(BuildContext context) {
    return SheetInformationScaffold(
      imageUrl: widget.parkActivity.image,
      title: widget.parkActivity.title,
      childrens: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.parkActivity.price! <= 0
                      ? const Text('Gratuito')
                      : Text(
                          'R\$ ${widget.parkActivity.price.toString()}',
                        ),
                ),
              ),
            ),
            widget.parkActivity.location != null
                ? StreamBuilder(
                    stream: widget.parkActivity.location!.snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                                  builder: (context) => LocationDetail(
                                    userProfile: widget.userProfile,
                                    locationWaypoint: locationWaypoint,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  locationWaypoint.name.toString(),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    })
                : Container(),
          ],
        ),
        const SizedBox(height: 16.0),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DescriptionLines(
              widget.parkActivity.description.toString(),
            ),
          ),
        ),
      ],
    );
  }
}
