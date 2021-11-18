import 'package:cloud_firestore/cloud_firestore.dart';

class ParkService {
  final String id;
  final String? title;
  final String? description;
  final bool? active;
  final String? image;
  final double? price;
  final DocumentReference? location;
  final List? roles;

  ParkService(
    this.id, {
    this.title,
    this.active,
    this.image,
    this.price,
    this.location,
    this.roles,
    this.description,
  });

  @override
  String toString() {
    return 'ParkService{id: $id,'
        ' title: $title,'
        ' description: $description,'
        ' active: $active,'
        ' image: $image,'
        ' price: $price,'
        ' location: $location,'
        ' roles: $roles}';
  }

  factory ParkService.fromSnapshot(QueryDocumentSnapshot serviceDocument) {
    final Map serviceData = serviceDocument.data() as Map<dynamic, dynamic>;
    return ParkService(
      serviceDocument.id,
      title: serviceData['title'],
      active: serviceData['active'],
      image: serviceData['image'],
      price: double.tryParse(serviceData['price'].toString()) ?? 0,
      location: serviceData['location'],
      roles: serviceData['roles'] ?? [],
      description: serviceData['description'],
    );
  }
}
