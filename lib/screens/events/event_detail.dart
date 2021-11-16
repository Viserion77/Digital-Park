import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/formater/date.dart';
import 'package:digital_park/models/events/event.dart';
import 'package:digital_park/models/locations/location_waypoint.dart';
import 'package:digital_park/models/user/user_profile.dart';
import 'package:digital_park/route_generator.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: SizedBox(
        height: 60,
        child: Row(
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
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              stretch: true,
              backgroundColor: Theme.of(context).primaryColor,
              expandedHeight: widget.parkEvent.image != null ? 400 : null,
              flexibleSpace: FlexibleSpaceBar(
                background: widget.parkEvent.image != null
                    ? ImageFlatBack(
                        image: widget.parkEvent.image.toString(),
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
                          widget.parkEvent.title.toString(),
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
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
                                  stream:
                                      widget.parkEvent.location!.snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data!.exists) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              LocationWaypoint.fromSnapshot(
                                                snapshot.data,
                                              ).name.toString(),
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
                          child: Text(
                            widget.parkEvent.description.toString(),
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
    final DocumentReference userReference = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userProfile.email);

    return FloatingActionButton.extended(
      onPressed: () {
        if (widget.userProfile.providerId == null) {
          Navigator.of(context).pop();
          navigatorRoute(context, '/anonymously-route',
              arguments: widget.userProfile);
        } else {
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
    final DocumentReference userReference = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userProfile.email);

    return FloatingActionButton(
      onPressed: () {
        if (widget.userProfile.providerId == null) {
          Navigator.of(context).pop();
          navigatorRoute(context, '/anonymously-route',
              arguments: widget.userProfile);
        } else {
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

class ImageFlatBack extends StatelessWidget {
  const ImageFlatBack({
    Key? key,
    required this.image,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                image,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 150,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.white,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
