import 'package:digital_park/screens/events/list.dart';
import 'package:digital_park/screens/sign/in.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'images/logo.png',
                  width: 64.0,
                ),
                Icon(Icons.input),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: Icon(Icons.monetization_on_outlined),
            title: Text('Serviços'),
            onTap: () => {},
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: Icon(Icons.label),
            title: Text('Sugestões'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: Icon(Icons.calendar_today_outlined),
            title: Text('Eventos'),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EventsList()),
              )
            },
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: Icon(Icons.directions_bike_outlined),
            title: Text('Atividades'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: Icon(Icons.text_snippet_outlined),
            title: Text('Informações'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: Icon(Icons.question_answer_sharp),
            title: Text('Pergunstas'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: Icon(Icons.qr_code),
            title: Text('Código QR'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () => {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
                ModalRoute.withName('/'),
              ),
            },
          ),
        ],
      ),
    );
  }
}
