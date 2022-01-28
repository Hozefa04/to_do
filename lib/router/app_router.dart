import 'package:flutter/material.dart';
import 'package:to_do/screens/home_page.dart';
import 'package:to_do/screens/landing_page.dart';
import 'package:to_do/screens/login_page.dart';

//Navigator.of(context).pushNamed('/');

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LandingPage());
        break;
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
        break;
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
        break;
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
