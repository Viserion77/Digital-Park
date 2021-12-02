import 'package:cloud_firestore/cloud_firestore.dart';

class Questions {
  final String id;
  final String? title;
  final String? description;
  final bool? active;
  final String? image;
  final List? roles;

  Questions(
    this.id, {
    this.title,
    this.active,
    this.image,
    this.roles,
    this.description,
  });

  @override
  String toString() {
    return 'ParkActivity{id: $id,'
        ' title: $title,'
        ' description: $description,'
        ' active: $active,'
        ' image: $image,'
        ' roles: $roles}';
  }

  factory Questions.fromSnapshot(QueryDocumentSnapshot serviceDocument) {
    final Map serviceData = serviceDocument.data() as Map<dynamic, dynamic>;
    return Questions(
      serviceDocument.id,
      title: serviceData['title'],
      active: serviceData['active'],
      image: serviceData['image'],
      roles: serviceData['roles'] ?? [],
      description: serviceData['description'],
    );
  }
}
