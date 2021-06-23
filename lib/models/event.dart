import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String name;
  final Timestamp startDate;

  Event(this.id, this.name, this.startDate);

  @override
  String toString() {
    return 'Event{id: $id, name: $name, startDate: $startDate}';
  }
}
