import 'package:cloud_firestore/cloud_firestore.dart';

class LocationWaypoint {
  final String id;
  final String? name;
  final String? description;
  final String? image;
  final bool? visible;
  final GeoPoint? wayPoint;
  final DocumentReference? reference;
  final List? roles;
  final List? tags;

  LocationWaypoint(
    this.id, {
    this.name,
    this.image,
    this.visible,
    this.wayPoint,
    this.reference,
    this.roles,
    this.tags,
    this.description,
  });

  @override
  String toString() {
    return 'Location{id: $id,'
        ' name: $name,'
        ' description: $description,'
        ' image: $image,'
        ' visible: $visible,'
        ' wayPoint: $wayPoint,'
        ' reference: $reference,'
        ' roles: $roles,'
        ' tags: $tags}';
  }

  factory LocationWaypoint.fromSnapshot(locationDocument) {
    final Map locationData = locationDocument.data() as Map<dynamic, dynamic>;

    final Map<String, dynamic> wayPointMap = locationData['wayPoint'] ?? {};
    final GeoPoint wayPoint = GeoPoint(
      double.tryParse(wayPointMap['_lat'].toString()) ?? 0,
      double.tryParse(wayPointMap['_long'].toString()) ?? 0,
    );

    return LocationWaypoint(
      locationDocument.id,
      name: locationData['name'],
      image: locationData['image'],
      visible: locationData['visible'],
      wayPoint: wayPoint,
      reference: locationData['reference'],
      roles: locationData['roles'],
      tags: locationData['tags'],
      description: locationData['description'],
    );
  }
}
