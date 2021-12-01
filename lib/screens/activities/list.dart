import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:digital_park/components/description_lines.dart';
import 'package:digital_park/models/services/service.dart';
import 'package:digital_park/models/user/user_profile.dart';
import 'package:digital_park/screens/services/service_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesList extends StatelessWidget {
  const ServicesList({
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
            .collection('services')
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
              itemBuilder: (context, index) => ServiceCard(
                parkService:
                    ParkService.fromSnapshot(snapshot.data!.docs[index]),
                userProfile: userProfile,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    Key? key,
    required this.parkService,
    required this.userProfile,
  }) : super(key: key);

  final ParkService parkService;
  final UserProfile userProfile;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ServiceDetail(
                userProfile: userProfile,
                parkService: parkService,
              ),
            ),
          );
        },
        title: Text(
          parkService.title.toString(),
          style: const TextStyle(
            fontSize: 36.0,
          ),
        ),
        subtitle: parkService.image != null
            ? Image.network(
                parkService.image.toString(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: DescriptionLines(
                  parkService.description.toString(),
                ),
              ),
      ),
    );
  }
}
