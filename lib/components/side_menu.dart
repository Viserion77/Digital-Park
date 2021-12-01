import 'package:digital_park/models/user/user_profile.dart';
import 'package:digital_park/provider/firebase_authentication.dart';
import 'package:digital_park/route_generator.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    Key? key,
    required this.userProfile,
  }) : super(key: key);
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => navigatorRoute(
                    context,
                    '/',
                    arguments: userProfile,
                  ),
                  child: Image.asset(
                    'images/logo.png',
                    width: 64.0,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_left),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            onTap: () => navigatorRoute(
              context,
              '/services',
              wantsPop: true,
              arguments: userProfile,
            ),
            title: const Text('Serviços'),
          ),
          ListTile(
            leading: const Icon(Icons.label),
            onTap: () => navigatorRoute(
              context,
              '/suggestion',
              wantsPop: true,
              arguments: userProfile,
            ),
            title: const Text('Sugestões'),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today_outlined),
            onTap: () => navigatorRoute(
              context,
              '/events',
              wantsPop: true,
              arguments: userProfile,
            ),
            title: Text('Eventos'),
          ),
          ListTile(
            leading: Icon(Icons.directions_bike_outlined),
            title: const Text('Atividades'),
            onTap: () => navigatorRoute(
              context,
              '/activities',
              wantsPop: true,
              arguments: userProfile,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.text_snippet_outlined),
            title: const Text('Informações'),
            onTap: () => navigatorRoute(
              context,
              '/informations',
              wantsPop: true,
              arguments: userProfile,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.question_answer_sharp),
            title: const Text('Perguntas'),
            onTap: () => navigatorRoute(
              context,
              '/questions',
              wantsPop: true,
              arguments: userProfile,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.qr_code),
            onTap: () => {Navigator.of(context).pop()},
            title: const Text('Códigos QR'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            onTap: () => {Navigator.of(context).pop()},
            title: Text('Configurações'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () async {
              navigatorRoute(
                context,
                '/',
                wantsPop: true,
                arguments: userProfile,
              );
              await FirebaseAuthenticationProvider().logout(
                notifyTheListeners: false,
              );
            },
          ),
        ],
      ),
    );
  }
}
