import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/description_lines.dart';
import 'package:digital_park/components/sheet_information_scaffold.dart';
import 'package:digital_park/models/activities.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:digital_park/screens/map/location_badge.dart';
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
                ? LocationBadge(
                    location: widget.parkActivity.location as DocumentReference,
                    userProfile: widget.userProfile,
                  )
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
