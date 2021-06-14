import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/pages/login_page.dart';
import 'package:mylearningcards_v1/pages/welcome_main_screen.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';

class AuthCheckRedirect extends StatelessWidget {
  static String id = 'AuthCheckRedirect';

  final UserFunctions uFunctions = UserFunctions();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: uFunctions.getLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              // this is your user instance
              /// is because there is user already logged
              return WelcomeMain();
            }

            /// other way there is no user logged.

          }
          return LoginPage();
        });
  }
}
