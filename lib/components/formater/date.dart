import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventMoment extends StatelessWidget {
  const EventMoment(this.moment, {Key? key}) : super(key: key);
  final Timestamp? moment;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('MMMM dd hh:mm aa'); // MMMM dd kk:mm
    return moment != null
        ? Text(dateFormatter.format(moment!.toDate()))
        : Container();
  }
}
