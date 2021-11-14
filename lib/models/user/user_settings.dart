class UserSettings {
  final int? id;
  late bool staySignIn;
  late String? provider;

  UserSettings(
    this.id, {
    this.staySignIn = false,
    this.provider,
  });

  @override
  String toString() {
    return 'UserSettings{id: $id, staySignIn: $staySignIn, provider: $provider}';
  }
}
