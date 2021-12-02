import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/buttons/background_button.dart';
import 'package:digital_park/components/status_message.dart';
import 'package:digital_park/models/activities.dart';
import 'package:digital_park/models/event.dart';
import 'package:digital_park/models/information.dart';
import 'package:digital_park/models/location_waypoint.dart';
import 'package:digital_park/models/service.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:digital_park/screens/activities/activit_detail.dart';
import 'package:digital_park/screens/events/event_detail.dart';
import 'package:digital_park/screens/informations/information_detail.dart';
import 'package:digital_park/screens/map/location_detail.dart';
import 'package:digital_park/screens/services/service_detail.dart';
import 'package:flutter/material.dart';

class ValidateQRCode extends StatefulWidget {
  const ValidateQRCode({
    Key? key,
    required this.qrValue,
    required this.userProfile,
  }) : super(key: key);
  final String qrValue;
  final UserProfile userProfile;

  @override
  State<ValidateQRCode> createState() => _ValidateQRCodeState();
}

class _ValidateQRCodeState extends State<ValidateQRCode> {
  @override
  Widget build(BuildContext context) {
    final List<String> qrLink = widget.qrValue.split('/');
    final int qrLinkSize = qrLink.length;
    final List<String> enabledCollections = [
      'events',
      'informations',
      'locations',
      'services',
      'activities',
    ];
    String collection = '';
    String document = '';
    if (qrLinkSize >= 2) {
      final String collectionLc = qrLink[qrLinkSize - 2].toLowerCase();
      if (enabledCollections.contains(collectionLc)) {
        collection = collectionLc;
      }
      document = qrLink[qrLinkSize - 1];
    }
    return collection == ''
        ? const ErrorMessageReading()
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(collection)
                .where(FieldPath.documentId, isEqualTo: document)
                .where('active', isEqualTo: true)
                .where('roles', arrayContainsAny: widget.userProfile.roles)
                .limit(1)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const ErrorMessageReading();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return StatusMessage(
                  loading: true,
                  errorMessage: 'Validando!',
                  children: [
                    BackgroundButton(
                      label: 'Voltar',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return StatusMessage(
                  errorIcon: Icons.warning,
                  errorMessage: 'Qr code não encontrado na base!',
                  children: [
                    BackgroundButton(
                      label: 'Voltar',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
              if (collection == 'events') {
                return EventDetail(
                  userProfile: widget.userProfile,
                  parkEvent: ParkEvent.fromSnapshot(
                    snapshot.data!.docs[0],
                  ),
                );
              }
              if (collection == 'information') {
                return InformationDetail(
                  userProfile: widget.userProfile,
                  information: Information.fromSnapshot(
                    snapshot.data!.docs[0],
                  ),
                );
              }
              if (collection == 'location') {
                return LocationDetail(
                  userProfile: widget.userProfile,
                  locationWaypoint: LocationWaypoint.fromSnapshot(
                    snapshot.data!.docs[0],
                  ),
                );
              }
              if (collection == 'services') {
                return ServiceDetail(
                  userProfile: widget.userProfile,
                  parkService: ParkService.fromSnapshot(
                    snapshot.data!.docs[0],
                  ),
                );
              }
              if (collection == 'activities') {
                return ActivityDetail(
                  userProfile: widget.userProfile,
                  parkActivity: ParkActivity.fromSnapshot(
                    snapshot.data!.docs[0],
                  ),
                );
              }

              return const ErrorMessageReading();
            },
          );
  }
}

class ErrorMessageReading extends StatelessWidget {
  const ErrorMessageReading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatusMessage(
      errorIcon: Icons.warning,
      errorMessage: 'Ocorreu algum erro ao tentar identificar o QRCode!',
      children: [
        BackgroundButton(
          label: 'Voltar',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
