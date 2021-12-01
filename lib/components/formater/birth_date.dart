import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthDate extends StatelessWidget {
  const BirthDate(this.moment, {Key? key}) : super(key: key);
  final Timestamp? moment;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd/MM/yyyy'); // MMMM dd kk:mm
    return moment != null
        ? Text(
            dateFormatter.format(moment!.toDate()),
            style: TextStyle(fontSize: 16),
          )
        : Container();
  }
}
