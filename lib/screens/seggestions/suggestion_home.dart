import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:digital_park/models/user/user_profile.dart';
import 'package:flutter/material.dart';

class SuggestionHome extends StatelessWidget {
  const SuggestionHome({
    Key? key,
    required this.userProfile,
  }) : super(key: key);
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return DefaultScaffoldApp(
      userProfile: userProfile,
      body: const CircularProgressIndicator(),
    );
  }
}