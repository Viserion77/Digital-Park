import 'package:digital_park/digital_park.dart';
import 'package:digital_park/screens/events/list.dart';
import 'package:digital_park/screens/map/map.dart';
import 'package:digital_park/screens/seggestions/suggestion_home.dart';
import 'package:digital_park/screens/services/list.dart';
import 'package:digital_park/screens/user/user.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const DigitalPark(),
        );
      case '/user':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => UserPage(),
        );
      case '/suggestion':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SuggestionHome(),
        );
      case '/services':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ServicesList(),
        );
      case '/map':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const MapScreen(),
        );
      case '/events':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const EventsList(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ErrorPage(),
        );
    }
  }
}

void navigatorRoute(
  BuildContext context,
  String routeName, {
  bool wantsPop = false,
}) {
  final String? actualRoute = ModalRoute.of(context)!.settings.name;
  if (actualRoute != routeName) {
    if (wantsPop) Navigator.of(context).pop();
    if (actualRoute == '/' || actualRoute == null) {
      Navigator.of(context).pushNamed(routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(routeName);
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Woow'));
  }
}
