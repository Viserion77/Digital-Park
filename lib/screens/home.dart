import 'package:digital_park/components/container_background.dart';
import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:digital_park/screens/activities/generate_activit_button.dart';
import 'package:digital_park/screens/events/next_event_card.dart';
import 'package:digital_park/screens/informations/get_qr_code_button.dart';
import 'package:digital_park/screens/informations/home_header_informations.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultScaffoldApp(
      body: ContainerBackground(
        child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: const [
            HomeHeaderInformations(),
            NextEventCard(),
            GenerateActivity(),
            GetQRCode(),
          ],
        ),
      ),
    );
  }
}
