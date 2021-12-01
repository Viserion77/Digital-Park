import 'package:digital_park/components/description_lines.dart';
import 'package:digital_park/components/sheet_information_scaffold.dart';
import 'package:digital_park/models/questions/questions.dart';
import 'package:digital_park/models/user/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionDetail extends StatefulWidget {
  const QuestionDetail({
    Key? key,
    required this.userProfile,
    required this.question,
  }) : super(key: key);
  final UserProfile userProfile;
  final Questions question;

  @override
  State<QuestionDetail> createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  @override
  Widget build(BuildContext context) {
    return SheetInformationScaffold(
      imageUrl: widget.question.image,
      title: widget.question.title,
      childrens: [
        const SizedBox(height: 16.0),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DescriptionLines(
              widget.question.description.toString(),
            ),
          ),
        ),
      ],
    );
  }
}
