import 'package:DigitalPark/components/basics.dart';
import 'package:DigitalPark/components/bottomMenuBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/basics.dart';
import 'events/list.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final TextEditingController _controllerLogin = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _staySignIn = false;
  final String _backgroundImageAsset = 'images/background.png';
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final DateFormat _hourFormat = DateFormat('hh:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundImageAsset),
            fit: BoxFit.cover,
          ),
        ),
        height: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 32.0,
            left: 32.0,
            right: 32.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  _dateFormat.format(DateTime.now()),
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: Theme.of(context).selectedRowColor,
                                  ),
                                ),
                                Text(
                                  _hourFormat.format(DateTime.now()),
                                  style: TextStyle(
                                    fontSize: 56.0,
                                    color: Theme.of(context).selectedRowColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Aberto até as 20:00',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Theme.of(context).selectedRowColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Text(
                        'Próximo evento',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Theme.of(context).selectedRowColor,
                        ),
                      ),
                      Container(
                        child: NextNearEvent(),
                      )
                    ],
                  ),
                ),
                Button(
                  label: 'Uma atividade para agora?',
                  onPressed: () {},
                  fontSize: 16.0,
                ),
                Button(
                  label: 'Achou um código QR, leia-o!',
                  onPressed: () {},
                  fontSize: 16.0,
                  imageAsset: 'images/icons/qr_code.png',
                  height: 56.0,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomMenuBar(),
    );
  }
}