import 'package:cloud_firestore/cloud_firestore.dart';

class ParkEvent {
  final String id;
  final String? title;
  final String? description;
  final bool? active;
  final Timestamp? startDate;
  final Timestamp? endDate;
  final String? image;
  final double? price;
  final DocumentReference? location;
  final List? roles;
  final List? favorite;
  final List? confirmedAttendance;

  ParkEvent(
    this.id, {
    this.title,
    this.active,
    this.startDate,
    this.endDate,
    this.image,
    this.price,
    this.location,
    this.roles,
    this.favorite,
    this.confirmedAttendance,
    this.description,
  });

  @override
  String toString() {
    return 'ParkEvent{id: $id,'
        ' title: $title,'
        ' description: $description,'
        ' active: $active,'
        ' startDate: $startDate,'
        ' endDate: $endDate,'
        ' image: $image,'
        ' price: $price,'
        ' location: $location,'
        ' roles: $roles,'
        ' favorite: $favorite,'
        ' confirmedAttendance: $confirmedAttendance}';
  }

  factory ParkEvent.fromSnapshot(QueryDocumentSnapshot eventDocument) {
    final Map eventData = eventDocument.data() as Map<dynamic, dynamic>;
    return ParkEvent(
      eventDocument.id,
      title: eventData['title'],
      active: eventData['active'],
      startDate: eventData['startDate'],
      endDate: eventData['endDate'],
      image: eventData['image'],
      price: double.tryParse(eventData['price'].toString()),
      location: eventData['location'],
      roles: eventData['roles'],
      favorite: eventData['favorite'],
      confirmedAttendance: eventData['confirmedAttendance'],
      description: eventData['description'],
    );
  }
}
