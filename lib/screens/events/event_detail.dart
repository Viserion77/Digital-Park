import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/description_lines.dart';
import 'package:digital_park/components/formater/date.dart';
import 'package:digital_park/components/sheet_information_scaffold.dart';
import 'package:digital_park/models/event.dart';
import 'package:digital_park/models/location_waypoint.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:digital_park/route_generator.dart';
import 'package:digital_park/screens/map/location_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({
    Key? key,
    required this.userProfile,
    required this.parkEvent,
  }) : super(key: key);
  final UserProfile userProfile;
  final ParkEvent parkEvent;

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    return SheetInformationScaffold(
      imageUrl: widget.parkEvent.image,
      title: widget.parkEvent.title,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButtonConfirm(
            userProfile: widget.userProfile,
            parkEvent: widget.parkEvent,
          ),
          FloatingActionButtonFavorite(
            userProfile: widget.userProfile,
            parkEvent: widget.parkEvent,
          ),
        ],
      ),
      childrens: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EventMoment(widget.parkEvent.startDate),
            const Text('-'),
            EventMoment(widget.parkEvent.endDate),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.parkEvent.price! <= 0
                      ? const Text('Gratuito')
                      : Text(
                          'R\$ ${widget.parkEvent.price.toString()}',
                        ),
                ),
              ),
            ),
            widget.parkEvent.location != null
                ? StreamBuilder(
                    stream: widget.parkEvent.location!.snapshots(),
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
              widget.parkEvent.description.toString(),
            ),
          ),
        ),
      ],
    );
  }
}

class FloatingActionButtonConfirm extends StatefulWidget {
  FloatingActionButtonConfirm({
    Key? key,
    required this.userProfile,
    required this.parkEvent,
  }) : super(key: key);
  final UserProfile userProfile;
  final ParkEvent parkEvent;

  late bool userConfirmedAttendance = parkEvent.confirmedAttendance!.any(
    (element) =>
        element.toString() ==
        FirebaseFirestore.instance
            .collection('users')
            .doc(userProfile.email)
            .toString(),
  );

  @override
  State<FloatingActionButtonConfirm> createState() =>
      _FloatingActionButtonConfirmState();
}

class _FloatingActionButtonConfirmState
    extends State<FloatingActionButtonConfirm> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        if (widget.userProfile.providerId == null) {
          navigatorRoute(
            context,
            '/anonymously-route',
            arguments: widget.userProfile,
            wantsPop: true,
          );
        } else {
          final DocumentReference userReference = FirebaseFirestore.instance
              .collection('users')
              .doc(widget.userProfile.email);
          FirebaseFirestore.instance
              .collection('events')
              .doc(widget.parkEvent.id)
              .update(widget.userConfirmedAttendance
                  ? {
                      'confirmedAttendance':
                          FieldValue.arrayRemove([userReference]),
                    }
                  : {
                      'confirmedAttendance':
                          FieldValue.arrayUnion([userReference]),
                    });
          setState(() {
            widget.userConfirmedAttendance = !widget.userConfirmedAttendance;
          });
        }
      },
      label: SizedBox(
        height: 60,
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.handPointUp,
              color: widget.userConfirmedAttendance
                  ? Colors.yellowAccent
                  : Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Eu irei',
                style: TextStyle(
                  color: widget.userConfirmedAttendance
                      ? Colors.yellowAccent
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FloatingActionButtonFavorite extends StatefulWidget {
  FloatingActionButtonFavorite({
    Key? key,
    required this.userProfile,
    required this.parkEvent,
  }) : super(key: key);

  final UserProfile userProfile;
  final ParkEvent parkEvent;
  late bool userFavorite = parkEvent.favorite!.any(
    (element) =>
        element.toString() ==
        FirebaseFirestore.instance
            .collection('users')
            .doc(userProfile.email)
            .toString(),
  );

  @override
  State<FloatingActionButtonFavorite> createState() =>
      _FloatingActionButtonFavoriteState();
}

class _FloatingActionButtonFavoriteState
    extends State<FloatingActionButtonFavorite> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (widget.userProfile.providerId == null) {
          navigatorRoute(
            context,
            '/anonymously-route',
            arguments: widget.userProfile,
            wantsPop: true,
          );
        } else {
          final DocumentReference userReference = FirebaseFirestore.instance
              .collection('users')
              .doc(widget.userProfile.email);
          FirebaseFirestore.instance
              .collection('events')
              .doc(widget.parkEvent.id)
              .update(widget.userFavorite
                  ? {
                      'favorite': FieldValue.arrayRemove([userReference]),
                    }
                  : {
                      'favorite': FieldValue.arrayUnion([userReference]),
                    });
          setState(() {
            widget.userFavorite = !widget.userFavorite;
          });
        }
      },
      child: FaIcon(
        FontAwesomeIcons.star,
        color: widget.userFavorite ? Colors.yellowAccent : Colors.white,
      ),
    );
  }
}
