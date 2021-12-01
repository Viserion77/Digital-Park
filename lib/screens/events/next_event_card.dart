import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/description_lines.dart';
import 'package:digital_park/models/events/event.dart';
import 'package:digital_park/models/user/user_profile.dart';
import 'package:digital_park/screens/events/event_detail.dart';
import 'package:flutter/material.dart';

class NextEventCard extends StatefulWidget {
  const NextEventCard({
    Key? key,
    required this.userProfile,
  }) : super(key: key);
  final UserProfile userProfile;

  @override
  _NextEventCardState createState() => _NextEventCardState();
}

class _NextEventCardState extends State<NextEventCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('events')
          .where('active', isEqualTo: true)
          .where('roles', arrayContainsAny: widget.userProfile.roles)
          .where('startDate', isGreaterThanOrEqualTo: Timestamp.now())
          .orderBy('startDate')
          .limit(1)
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
        return EventCard(
          nextEvent: ParkEvent.fromSnapshot(snapshot.data!.docs[0]),
          userProfile: widget.userProfile,
        );
      },
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
      color: Theme.of(context).primaryColor,
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
        title: const Text(
          'Próximo Evento!',
          style: TextStyle(
            fontSize: 36.0,
            color: Colors.white,
          ),
        ),
        subtitle: nextEvent.image != null
            ? Image.network(
                nextEvent.image.toString(),
              )
            : Column(
                children: [
                  Text(
                    nextEvent.title.toString(),
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DescriptionLines(
                      nextEvent.description.toString(),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
