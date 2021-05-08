class Session {
  final int id;
  final String authToken;
  final bool staySignIn;

  Session(
    this.id,
    this.authToken,
    this.staySignIn,
  );

  @override
  String toString() {
    return 'Event{id: $id, authToken: $authToken, staySignIn: $staySignIn}';
  }

  bool isAuthenticated() {
    return this.authToken != '';
  }
}
