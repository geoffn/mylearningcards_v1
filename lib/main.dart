import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/components/card_sets_view.dart';
import 'package:mylearningcards_v1/pages/new_cardset.dart';
import 'package:mylearningcards_v1/pages/welcome_cards.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mylearningcards_v1/components/oauth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyLearningCards());
}

class MyLearningCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFC7FFD8),
        scaffoldBackgroundColor: Colors.white,
        accentColor: Colors.purple,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        WelcomeMain.id: (context) => WelcomeMain(),
        NewCardset.id: (context) => NewCardset(),
      },
    );
  }
}
