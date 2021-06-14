import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/pages/card_view_main_screen.dart';
import 'package:mylearningcards_v1/pages/login_page.dart';
import 'package:mylearningcards_v1/pages/new_cardset.dart';
import 'package:mylearningcards_v1/pages/welcome_main_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    //final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/welcome':
        return MaterialPageRoute(builder: (_) => WelcomeMain());
      case '/newcardset':
        return MaterialPageRoute(builder: (_) => NewCardset());
      case '/cardview':
        return MaterialPageRoute(
          builder: (_) => CardViewMain(),
        );

      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
