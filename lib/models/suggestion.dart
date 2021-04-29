class Suggestion {
  final int id;
  final String name;
  final int numero;

  Suggestion(
    this.id,
    this.name,
    this.numero,
  );

  @override
  String toString() {
    return 'Suggestion{id: $id, name: $name, numero: $numero}';
  }
}
