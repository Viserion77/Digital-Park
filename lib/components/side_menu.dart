import 'package:digital_park/database/dao/user_settings_dao.dart';
import 'package:digital_park/models/user/user_settings.dart';
import 'package:digital_park/provider/firebase_authentication.dart';
import 'package:digital_park/route_generator.dart';
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
                  onTap: () => navigatorRoute(context, '/'),
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
            onTap: () => navigatorRoute(context, '/services', wantsPop: true),
            title: const Text('Services'),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.monetization_on_outlined),
            onTap: () => navigatorRoute(context, '/map', wantsPop: true),
            title: const Text('mapa'),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.person),
            onTap: () => navigatorRoute(context, '/user', wantsPop: true),
            title: const Text('Perfil'),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.label),
            onTap: () => navigatorRoute(context, '/suggestion', wantsPop: true),
            title: const Text('Sugestões'),
          ),
          ListTile(
            tileColor: Theme.of(context).primaryColor,
            leading: const Icon(Icons.calendar_today_outlined),
            onTap: () => navigatorRoute(context, '/events', wantsPop: true),
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
            onTap: () async {
              final UserSettings userSettings = await UserSettingsDao().find();
              await FirebaseAuthenticationProvider().logout(
                notifyTheListeners: false,
                google: userSettings.provider == 'google',
              );
            },
          ),
        ],
      ),
    );
  }
}
