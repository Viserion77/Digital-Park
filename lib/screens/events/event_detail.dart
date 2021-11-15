import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/models/events/event.dart';
import 'package:digital_park/models/user/user_profile.dart';
import 'package:digital_park/route_generator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventDetail extends StatefulWidget {
  EventDetail({
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
  late bool userFavorite = parkEvent.favorite!.any(
    (element) =>
        element.toString() ==
        FirebaseFirestore.instance
            .collection('users')
            .doc(userProfile.email)
            .toString(),
  );

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    final DocumentReference userReference = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userProfile.email);

    return Scaffold(
      floatingActionButton: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton.extended(
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
                    widget.userConfirmedAttendance =
                        !widget.userConfirmedAttendance;
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
            ),
            FloatingActionButton(
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
                              'favorite':
                                  FieldValue.arrayRemove([userReference]),
                            }
                          : {
                              'favorite':
                                  FieldValue.arrayUnion([userReference]),
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
                    ? Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.parkEvent.image.toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    50,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Column(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.parkEvent.title.toString(),
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text('Começa em'),
                              Text(widget.parkEvent.startDate!
                                  .toDate()
                                  .toString()),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Termina em'),
                              Text(widget.parkEvent.endDate!
                                  .toDate()
                                  .toString()),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              widget.parkEvent.price.toString(),
                            ),
                            const Text('Valor R\$'),
                          ],
                        ),
                      ),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.parkEvent.location.toString(),
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
