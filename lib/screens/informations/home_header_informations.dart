import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/models/informations/information.dart';
import 'package:flutter/material.dart';

class HomeHeaderInformations extends StatelessWidget {
  const HomeHeaderInformations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime actualMoment = DateTime(
      1970,
      1,
      1,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    );

    var informationsFilter = FirebaseFirestore.instance
        .collection('informations')
        .where('active', isEqualTo: true)
        .where('showInHome.enable', isEqualTo: true)
        .where('showInHome.weekday', arrayContainsAny: [DateTime.now().weekday])
        .where('showInHome.startedShowAt', isLessThanOrEqualTo: actualMoment)
        .orderBy('showInHome.startedShowAt', descending: true)
        .limit(1)
        .snapshots();

    return StreamBuilder(
      stream: informationsFilter,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isNotEmpty) {
            final Information information =
                Information.fromSnapshot(snapshot.data!.docs[0]);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const DateHour(),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      information.description.toString(),
                      softWrap: true,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            DateHour(),
          ],
        );
      },
    );
  }
}

class DateHour extends StatefulWidget {
  const DateHour({
    Key? key,
  }) : super(key: key);

  @override
  State<DateHour> createState() => _DateHourState();
}

class _DateHourState extends State<DateHour> {
  @override
  Widget build(BuildContext context) {
    late String dateNow = normalizeDate(DateTime.now().day.toString()) +
        '/' +
        normalizeDate(DateTime.now().month.toString()) +
        '/' +
        DateTime.now().year.toString();

    late String hourNow = normalizeDate(DateTime.now().hour.toString()) +
        ':' +
        normalizeDate(DateTime.now().minute.toString());

    Future.delayed(
      const Duration(seconds: 1),
      () => setState(() {}),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dateNow,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        Text(
          hourNow,
          style: const TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String normalizeDate(String time) =>
      int.tryParse(time)! > 9 ? time : '0$time';
}
