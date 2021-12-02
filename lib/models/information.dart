import 'package:cloud_firestore/cloud_firestore.dart';

class Information {
  final String id;
  final String? description;
  final String? title;
  final String? image;
  final List? roles;

  Information(
    this.id, {
    this.description,
    this.title,
    this.image,
    this.roles,
  });

  @override
  String toString() {
    return 'Information{id: $id, description: $description, roles: $roles}';
  }

  factory Information.fromSnapshot(QueryDocumentSnapshot informationDocument) {
    final Map informationData =
        informationDocument.data() as Map<dynamic, dynamic>;
    return Information(
      informationDocument.id,
      description: informationData['description'],
      title: informationData['title'],
      image: informationData['image'],
      roles: informationData['roles'] ?? [],
    );
  }
}
