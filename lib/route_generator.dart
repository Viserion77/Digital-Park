import 'package:digital_park/components/back_and_sign_in.dart';
import 'package:digital_park/digital_park.dart';
import 'package:digital_park/models/user/user_profile.dart';
import 'package:digital_park/screens/events/list.dart';
import 'package:digital_park/screens/map/map.dart';
import 'package:digital_park/screens/seggestions/suggestion_home.dart';
import 'package:digital_park/screens/services/list.dart';
import 'package:digital_park/screens/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final bool anonymouslyMode =
        FirebaseAuth.instance.currentUser!.providerData.isEmpty;
    final List<String> noAnonymouslyRoutes = ['/user'];
    final args = settings.arguments;

    if (anonymouslyMode &&
        noAnonymouslyRoutes
            .any((noAnonymouslyRoute) => noAnonymouslyRoute == settings.name)) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const BackAndSignIn(),
      );
    }

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const DigitalPark(),
        );
      case '/user':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => UserPage(
            userProfile: args as UserProfile,
          ),
        );
      case '/suggestion':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => SuggestionHome(
            userProfile: args as UserProfile,
          ),
        );
      case '/services':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ServicesList(
            userProfile: args as UserProfile,
          ),
        );
      case '/map':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MapScreen(
            userProfile: args as UserProfile,
          ),
        );
      case '/events':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => EventsList(
            userProfile: args as UserProfile,
          ),
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
  required UserProfile arguments,
}) {
  final String? actualRoute = ModalRoute.of(context)!.settings.name;
  if (actualRoute != routeName) {
    if (wantsPop) Navigator.of(context).pop();
    if (actualRoute == '/' || actualRoute == null) {
      Navigator.of(context).pushNamed(routeName, arguments: arguments);
    } else {
      Navigator.of(context)
          .pushReplacementNamed(routeName, arguments: arguments);
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
