import 'package:digital_park/components/description_lines.dart';
import 'package:digital_park/components/sheet_information_scaffold.dart';
import 'package:digital_park/models/location_waypoint.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationDetail extends StatefulWidget {
  const LocationDetail({
    Key? key,
    required this.userProfile,
    required this.locationWaypoint,
  }) : super(key: key);
  final UserProfile userProfile;
  final LocationWaypoint locationWaypoint;

  @override
  State<LocationDetail> createState() => _LocationDetailState();
}

class _LocationDetailState extends State<LocationDetail> {
  @override
  Widget build(BuildContext context) {
    return SheetInformationScaffold(
      imageUrl: widget.locationWaypoint.image,
      title: widget.locationWaypoint.name,
      childrens: [
        const SizedBox(height: 16.0),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DescriptionLines(
              widget.locationWaypoint.description.toString(),
            ),
          ),
        ),
      ],
    );
  }
}
