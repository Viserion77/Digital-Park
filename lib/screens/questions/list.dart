import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:digital_park/models/questions/questions.dart';
import 'package:digital_park/models/user/user_profile.dart';
import 'package:digital_park/screens/questions/question_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionsList extends StatelessWidget {
  const QuestionsList({
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
            .collection('questions')
            .where('active', isEqualTo: true)
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
              itemBuilder: (context, index) => QuestionCard(
                question: Questions.fromSnapshot(snapshot.data!.docs[index]),
                userProfile: userProfile,
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
    required this.userProfile,
  }) : super(key: key);

  final Questions question;
  final UserProfile userProfile;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => QuestionDetail(
                userProfile: userProfile,
                question: question,
              ),
            ),
          );
        },
        title: Text(
          question.title.toString(),
          style: const TextStyle(
            fontSize: 36.0,
          ),
        ),
        subtitle: question.image != null
            ? Image.network(
                question.image.toString(),
              )
            : Container(),
      ),
    );
  }
}
