import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/models/event.dart';
import 'package:flutter/material.dart';

import 'components/event.dart';

class EventsList extends StatelessWidget {
  final List<Event> events = [];
  final String _userEmail = 'jeferson_alves1@estudante.sc.senai.br';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              'images/logo.png',
              width: 40,
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('events')
            .where('active', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data.documents.length == 0) {
            return Center(
              child: Text('Nenhum evento ainda'),
            );
          }
          print(snapshot);
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int i) {
              final Event event = new Event(
                  snapshot.data.documents[i].documentID,
                  snapshot.data.documents[i].data['title'],
                  snapshot.data.documents[i].data['startDate']);
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => EventDetail(
                              event: event,
                            )),
                  );
                },
                child: _EventItem(event),
              );
            },
          );
        },
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  final Event event;

  _EventItem(this.event);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(
          children: [
            Container(
              height: 240.0,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/logo.png'),
                ),
              ),
            ),
            Text(
              event.name,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
        subtitle: Text(
          DateTime.fromMillisecondsSinceEpoch(event.startDate.seconds * 1000)
              .toString(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
