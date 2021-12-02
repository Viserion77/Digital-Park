import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/description_lines.dart';
import 'package:digital_park/components/sheet_information_scaffold.dart';
import 'package:digital_park/models/location_waypoint.dart';
import 'package:digital_park/models/service.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:digital_park/screens/map/location_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceDetail extends StatefulWidget {
  const ServiceDetail({
    Key? key,
    required this.userProfile,
    required this.parkService,
  }) : super(key: key);
  final UserProfile userProfile;
  final ParkService parkService;

  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  @override
  Widget build(BuildContext context) {
    return SheetInformationScaffold(
      imageUrl: widget.parkService.image,
      title: widget.parkService.title,
      childrens: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.parkService.price! <= 0
                      ? const Text('Gratuito')
                      : Text(
                          'R\$ ${widget.parkService.price.toString()}',
                        ),
                ),
              ),
            ),
            widget.parkService.location != null
                ? StreamBuilder(
                    stream: widget.parkService.location!.snapshots(),
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
            child: SingleChildScrollView(
              child: DescriptionLines(
                widget.parkService.description.toString(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
