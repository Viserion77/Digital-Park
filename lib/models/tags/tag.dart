import 'package:cloud_firestore/cloud_firestore.dart';

class Tag {
  final String id;
  final String? description;

  Tag(
    this.id, {
    this.description,
  });

  @override
  String toString() {
    return 'Tag{id: $id, description: $description}';
  }

  factory Tag.fromSnapshot(QueryDocumentSnapshot tagDocument) {
    final Map tagData = tagDocument.data() as Map<dynamic, dynamic>;
    return Tag(
      tagDocument.id,
      description: tagData['description'],
    );
  }
}
