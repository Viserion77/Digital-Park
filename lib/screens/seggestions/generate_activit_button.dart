import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/buttons/background_button.dart';
import 'package:digital_park/models/activities.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:digital_park/screens/activities/activit_detail.dart';
import 'package:flutter/material.dart';

class GenerateSuggestion extends StatefulWidget {
  const GenerateSuggestion({
    Key? key,
    required this.userProfile,
  }) : super(key: key);
  final UserProfile userProfile;

  @override
  State<GenerateSuggestion> createState() => _GenerateSuggestionState();
}

class _GenerateSuggestionState extends State<GenerateSuggestion> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('activities')
          .where('active', isEqualTo: true)
          .where('roles', arrayContainsAny: widget.userProfile.roles)
          .limit(1)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const SizedBox(
            height: 52,
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const SizedBox(
            height: 52,
          );
        }
        return BackgroundButton(
          label: 'Uma atividade para agora?',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ActivityDetail(
                  userProfile: widget.userProfile,
                  parkActivity: ParkActivity.fromSnapshot(
                    snapshot.data!.docs[0],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
