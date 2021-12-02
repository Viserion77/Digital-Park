import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:digital_park/components/description_lines.dart';
import 'package:digital_park/models/information.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:digital_park/screens/informations/information_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformationsList extends StatelessWidget {
  const InformationsList({
    Key? key,
    required this.userProfile,
  }) : super(key: key);
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return DefaultScaffoldApp(
      userProfile: userProfile,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('informations')
            .where('active', isEqualTo: true)
            .where('roles', arrayContainsAny: userProfile.roles)
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
          return Container(
            color: Theme.of(context).secondaryHeaderColor,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => InformationCard(
                information:
                    Information.fromSnapshot(snapshot.data!.docs[index]),
                userProfile: userProfile,
              ),
            ),
          );
        },
      ),
    );
  }
}

class InformationCard extends StatelessWidget {
  const InformationCard({
    Key? key,
    required this.information,
    required this.userProfile,
  }) : super(key: key);

  final Information information;
  final UserProfile userProfile;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InformationDetail(
                userProfile: userProfile,
                information: information,
              ),
            ),
          );
        },
        title: Text(
          information.title.toString(),
          style: const TextStyle(
            fontSize: 36.0,
          ),
        ),
        subtitle: information.image != null
            ? Image.network(
                information.image.toString(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: DescriptionLines(
                  information.description.toString(),
                ),
              ),
      ),
    );
  }
}
