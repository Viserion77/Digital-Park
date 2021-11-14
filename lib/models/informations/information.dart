import 'package:cloud_firestore/cloud_firestore.dart';

class Information {
  final String id;
  final String? description;

  Information(
    this.id, {
    this.description,
  });

  @override
  String toString() {
    return 'Information{id: $id, description: $description}';
  }

  factory Information.fromSnapshot(QueryDocumentSnapshot informationDocument) {
    final Map informationData =
        informationDocument.data() as Map<dynamic, dynamic>;
    return Information(
      informationDocument.id,
      description: informationData['description'],
    );
  }
}
