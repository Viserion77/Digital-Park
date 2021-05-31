import 'package:digital_park/models/event.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatelessWidget {
  final Event event;

  const EventDetail({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Column(
          children: [
            Text(event.name),
            Text(DateTime.fromMillisecondsSinceEpoch(
                    event.startDate.seconds * 1000)
                .toString()),
            Container(
              height: 240.0,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/logo.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
