class Session {
  final int id;
  final String login;
  final String password;

  Session(
    this.id,
    this.login,
    this.password,
  );

  @override
  String toString() {
    return 'Event{id: $id, login: $login, password: $password}';
  }
}
