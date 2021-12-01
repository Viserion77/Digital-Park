import 'package:digital_park/components/sheet_information_scaffold.dart';
import 'package:digital_park/models/informations/information.dart';
import 'package:digital_park/models/user/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformationDetail extends StatefulWidget {
  const InformationDetail({
    Key? key,
    required this.userProfile,
    required this.information,
  }) : super(key: key);
  final UserProfile userProfile;
  final Information information;

  @override
  State<InformationDetail> createState() => _InformationDetailState();
}

class _InformationDetailState extends State<InformationDetail> {
  @override
  Widget build(BuildContext context) {
    return SheetInformationScaffold(
      title: widget.information.description,
      childrens: [Text('Implement')],
    );
  }
}
