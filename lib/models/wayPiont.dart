class WayPoint {
  final String id;
  final String name;
  final String description;
  final String image;

  WayPoint(this.id, this.name, this.description, this.image);

  @override
  String toString() {
    return 'Event{id: $id, name: $name}';
  }
}
