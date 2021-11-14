import 'package:digital_park/screens/events/list.dart';
import 'package:digital_park/screens/home.dart';
import 'package:digital_park/screens/map/map.dart';
import 'package:digital_park/screens/seggestions/suggestion_home.dart';
import 'package:digital_park/screens/services/list.dart';
import 'package:digital_park/screens/user/user.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

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
                GestureDetector(
                  onTap: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Home()),
                    )
                  },
                  child: Image.asset(
                    'images/logo.png',
                    width: 64.0,
                  ),
                ),
                GestureDetector(
                    onTap: () => {}, child: const Icon(Icons.input)),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.monetization_on_outlined),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ServicesList()),
              );
            },
            title: const Text('Services'),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.monetization_on_outlined),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MapScreen()),
              );
            },
            title: const Text('mapa'),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.person),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UserPage()),
              )
            },
            title: const Text('Perfil'),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.label),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SuggestionHome()),
              );
            },
            title: const Text('Sugestões'),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.calendar_today_outlined),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EventsList()),
              );
            },
            title: Text('Eventos'),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: Icon(Icons.directions_bike_outlined),
            title: const Text('Atividades'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.text_snippet_outlined),
            title: const Text('Informações'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.question_answer_sharp),
            title: const Text('Personas'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.qr_code),
            onTap: () => {Navigator.of(context).pop()},
            title: const Text('Código QR'),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.settings),
            onTap: () => {Navigator.of(context).pop()},
            title: Text('Configurações'),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
