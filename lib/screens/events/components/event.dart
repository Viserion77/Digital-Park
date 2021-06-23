import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/basics.dart';
import 'package:digital_park/models/event.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatelessWidget {
  final Event event;
  final String _userEmail = 'jeferson_alves1@estudante.sc.senai.br';

  const EventDetail({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Column(
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
            Container(
              height: 8.0,
              width: double.maxFinite,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.name,
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                Button(
                  icon: Icons.close,
                  label: '',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            Text(
              DateTime.fromMillisecondsSinceEpoch(
                      event.startDate.seconds * 1000)
                  .toString(),
            ),
            Button(
              label: 'Eu irei',
              onPressed: () {
                Firestore.instance
                    .collection('events')
                    .document(event.id)
                    .updateData({
                  'confirmedAttendance': FieldValue.arrayUnion([
                    Firestore.instance.collection('users').document(_userEmail)
                  ])
                });
              },
            ),
            Button(
              icon: Icons.star,
              label: 'Favorito',
              onPressed: () {
                Firestore.instance
                    .collection('events')
                    .document(event.id)
                    .updateData({
                  'favorite': FieldValue.arrayUnion([
                    Firestore.instance.collection('users').document(_userEmail)
                  ])
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
