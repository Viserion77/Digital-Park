import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/bottom_menu_bar.dart';
import 'package:digital_park/models/event.dart';
import 'package:flutter/material.dart';

import 'components/event.dart';

class EventsList extends StatelessWidget {
  final List<Event> events = [];
  final String _userEmail = 'jeferson_alves1@estudante.sc.senai.br';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  snapshot.data.documents[i].data['description'] != ""
                      ? snapshot.data.documents[0].data['description']
                      : "",
                  snapshot.data.documents[i].data['startDate'],
                  snapshot.data.documents[i].data['image']);
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => EventDetail(
                              event: event,
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: _EventItem(event),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomMenuBar(),
    );
  }
}

class _EventItem extends StatelessWidget {
  final Event event;

  _EventItem(this.event);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: ListTile(
        title: Column(
          children: [
            Container(
              height: 240.0,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                image: DecorationImage(
                  image: NetworkImage(event.image != null
                      ? event.image
                      : "http://grupomalwee.s3.amazonaws.com/uploads/midias/original/1320.jpg"),
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
