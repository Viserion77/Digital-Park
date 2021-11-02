import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/models/event.dart';
import 'package:digital_park/screens/events/components/event.dart';
import 'package:flutter/material.dart';

class NextEvent extends StatefulWidget {
  @override
  _NextEventState createState() => _NextEventState();
}

class _NextEventState extends State<NextEvent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Text(
            'Próximo evento',
            style: TextStyle(
              fontSize: 24.0,
              color: Theme.of(context).selectedRowColor,
            ),
          ),
          Container(
            child: NextNearEvent(),
          )
        ],
      ),
    );
  }
}

class NextNearEvent extends StatelessWidget {
  final String _userEmail = 'jeferson_alves1@estudante.sc.senai.br';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('events')
          .where('startDate', isGreaterThanOrEqualTo: new DateTime.now())
          .orderBy('startDate')
          .limit(1)
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
            child: Text('Nenhum evento proximo'),
          );
        }
        final Event event = new Event(
            snapshot.data.documents[0].documentID,
            snapshot.data.documents[0].data['title'],
            snapshot.data.documents[0].data['description'] != ""
                ? snapshot.data.documents[0].data['description']
                : "",
            snapshot.data.documents[0].data['startDate'],
            snapshot.data.documents[0].data['image']);
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EventDetail(
                  event: event,
                ),
              ),
            );
          },
          child: Card(
            child: Column(
              children: [
                Container(
                  height: 240.0,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(event.image != null
                          ? event.image
                          : "http://grupomalwee.s3.amazonaws.com/uploads/midias/original/1320.jpg"),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
