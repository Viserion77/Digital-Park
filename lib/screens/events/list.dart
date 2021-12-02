import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:digital_park/components/description_lines.dart';
import 'package:digital_park/models/event.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:digital_park/screens/events/event_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventsList extends StatelessWidget {
  const EventsList({
    Key? key,
    required this.userProfile,
  }) : super(key: key);
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return DefaultScaffoldApp(
      userProfile: userProfile,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('events')
            .where('active', isEqualTo: true)
            .where('roles', arrayContainsAny: userProfile.roles)
            .orderBy('startDate')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const SizedBox(
              height: 52,
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const SizedBox(
              height: 52,
            );
          }
          return Container(
            color: Theme.of(context).secondaryHeaderColor,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => EventCard(
                nextEvent: ParkEvent.fromSnapshot(snapshot.data!.docs[index]),
                userProfile: userProfile,
              ),
            ),
          );
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
    required this.nextEvent,
    required this.userProfile,
  }) : super(key: key);

  final ParkEvent nextEvent;
  final UserProfile userProfile;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EventDetail(
                userProfile: userProfile,
                parkEvent: nextEvent,
              ),
            ),
          );
        },
        title: Text(
          nextEvent.title.toString(),
          style: const TextStyle(
            fontSize: 36.0,
          ),
        ),
        subtitle: nextEvent.image != null
            ? Image.network(
                nextEvent.image.toString(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: DescriptionLines(
                  nextEvent.description.toString(),
                ),
              ),
      ),
    );
  }
}
