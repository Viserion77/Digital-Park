class Event {
  final int id;
  final String name;
  final int numero;

  Event(
    this.id,
    this.name,
    this.numero,
  );

  @override
  String toString() {
    return 'Event{id: $id, name: $name, numero: $numero}';
  }
}
