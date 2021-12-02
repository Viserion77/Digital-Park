import 'dart:ui';

import 'package:digital_park/components/image_flat_back.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              stretch: true,
              backgroundColor: Theme.of(context).primaryColor,
              expandedHeight:
                  widget.locationWaypoint.image != null ? 400 : null,
              flexibleSpace: FlexibleSpaceBar(
                background: widget.locationWaypoint.image != null
                    ? ImageFlatBack(
                        image: widget.locationWaypoint.image.toString(),
                      )
                    : null,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    50,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8.0),
                      Flexible(
                        child: Text(
                          widget.locationWaypoint.name.toString(),
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.locationWaypoint.description.toString(),
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
