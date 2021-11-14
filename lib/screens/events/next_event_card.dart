import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NextEventCard extends StatefulWidget {
  const NextEventCard({Key? key}) : super(key: key);

  @override
  _NextEventCardState createState() => _NextEventCardState();
}

class _NextEventCardState extends State<NextEventCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('events')
          .where('startDate', isGreaterThanOrEqualTo: DateTime.now())
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text('Nenhum evento proximo'),
          );
        }
        return const SizedBox(height: 300, child: CircularProgressIndicator());
      },
    );
  }
}
