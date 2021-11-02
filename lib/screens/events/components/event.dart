import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/basics.dart';
import 'package:digital_park/components/bottom_menu_bar.dart';
import 'package:digital_park/components/side_menu.dart';
import 'package:digital_park/models/event.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatelessWidget {
  final Event event;
  final String _userEmail = 'jeferson_alves1@estudante.sc.senai.br';

  const EventDetail({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                ),
                Container(
                  height: 8.0,
                  width: double.maxFinite,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
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
                Text(
                  event.description,
                  style: TextStyle(
                    fontSize: 36.0,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(
                  label: 'Eu irei',
                  onPressed: () {
                    Firestore.instance
                        .collection('events')
                        .document(event.id)
                        .updateData({
                      'confirmedAttendance': FieldValue.arrayUnion([
                        Firestore.instance
                            .collection('users')
                            .document(_userEmail)
                      ])
                    });
                  },
                ),
                Button(
                  icon: Icons.star,
                  label: '',
                  onPressed: () {
                    Firestore.instance
                        .collection('events')
                        .document(event.id)
                        .updateData({
                      'favorite': FieldValue.arrayUnion([
                        Firestore.instance
                            .collection('users')
                            .document(_userEmail)
                      ])
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenuBar(),
    );
  }
}
