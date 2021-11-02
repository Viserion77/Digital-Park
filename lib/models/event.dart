import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String name;
  final String description;
  final String image;
  final Timestamp startDate;

  Event(this.id, this.name, this.description, this.startDate, this.image);

  @override
  String toString() {
    return 'Event{id: $id, name: $name, startDate: $startDate}';
  }
}
