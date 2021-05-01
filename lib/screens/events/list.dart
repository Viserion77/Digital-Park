import 'package:DigitalPark/models/event.dart';
import 'package:DigitalPark/screens/events/form.dart';
import 'package:flutter/material.dart';

class EventsList extends StatelessWidget {
  final List<Event> events = List();
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          final Event event = events[index];
          return _EventItem(event);
        },
        itemCount: events.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(builder: (context) => EventForm()),
              )
              .then((newEvent) => debugPrint(newEvent.toString()));
        },
        child: Icon(
          Icons.add,
        ),
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
        title: Text(
          event.name,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          event.numero.toString(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class NextNearEvent extends StatelessWidget {
  final Event event = Event(0, 'aqui vem a imagem', 0);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            height: 240.0,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/logo.png'),
            ))));
  }
}
