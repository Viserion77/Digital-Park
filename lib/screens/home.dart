import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_park/components/buttons/background_button.dart';
import 'package:digital_park/components/buttons/fa_button.dart';
import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:digital_park/models/informations/information.dart';
import 'package:digital_park/screens/events/next_event_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultScaffoldApp(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top +
            (8.0 * (9.0)),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const HomeHeader(),
            const NextEventCard(),
            BackgroundButton(
              label: 'Uma atividade para agora?',
              onPressed: () {},
            ),
            FaButton(
              label: 'Achou um código QR, leia-o!',
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.qrcode,
                size: 78.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('informations')
          .where(
            'active',
            isEqualTo: true,
          )
          .where(
            'showInHome.enable',
            isEqualTo: true,
          )
          .where(
            'showInHome.weekday',
            arrayContainsAny: [DateTime.now().weekday],
          )
          .where(
            'showInHome.startedShowAt',
            isLessThanOrEqualTo: DateTime(
              1970,
              1,
              1,
              DateTime.now().hour,
              DateTime.now().minute,
              DateTime.now().second,
            ),
          )
          .orderBy(
            'showInHome.startedShowAt',
            descending: true,
          )
          .limit(1)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isNotEmpty) {
            final Information information =
                Information.fromSnapshot(snapshot.data!.docs[0]);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const DateHour(),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      information.description.toString(),
                      softWrap: true,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            DateHour(),
          ],
        );
      },
    );
  }
}

class DateHour extends StatefulWidget {
  const DateHour({
    Key? key,
  }) : super(key: key);

  @override
  State<DateHour> createState() => _DateHourState();
}

class _DateHourState extends State<DateHour> {
  @override
  Widget build(BuildContext context) {
    late String dateNow = DateTime.now().day.toString() +
        '/' +
        DateTime.now().month.toString() +
        '/' +
        DateTime.now().year.toString();

    late String hourNow = DateTime.now().hour.toString() +
        ':' +
        (DateTime.now().minute < 10 ? '0' : '') +
        DateTime.now().minute.toString();

    Future.delayed(
      const Duration(seconds: 1),
      () => setState(() {}),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dateNow,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        Text(
          hourNow,
          style: const TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
