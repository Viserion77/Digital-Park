class Service {
  final int id;
  final String name;
  final int numero;

  Service(
    this.id,
    this.name,
    this.numero,
  );

  @override
  String toString() {
    return 'Service{id: $id, name: $name, numero: $numero}';
  }
}
