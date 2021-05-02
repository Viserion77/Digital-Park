import 'package:DigitalPark/database/dao/session_dao.dart';
import 'package:DigitalPark/screens/home.dart';
import 'package:DigitalPark/screens/sign/in.dart';
import 'package:flutter/material.dart';

import 'models/session.dart';

void main() {
  runApp(DigitalPark());
}

class DigitalPark extends StatelessWidget {
  SessionDao sessionDao = SessionDao();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightGreen,
        accentColor: Colors.lightGreen[600],
        backgroundColor: Colors.grey[50],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.lightGreen,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: FutureBuilder<Session>(
        initialData: Session(0, '', false),
        future: sessionDao.getLast(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator(), Text('Digital Park')],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.data != null && snapshot.data.isAuthenticated()) {
                return Home();
              } else {
                return Login();
              }
              break;
          }
          return Text('Unknown error');
        },
      ),
    );
  }
}
