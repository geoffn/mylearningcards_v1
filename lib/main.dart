import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/components/scratchpad/editcardset_scratch.dart';
import 'package:mylearningcards_v1/pages/card_view_screen.dart';
import 'package:mylearningcards_v1/pages/edit_cardset.dart';
import 'package:mylearningcards_v1/pages/new_cardset.dart';
import 'package:mylearningcards_v1/pages/welcome_cards.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

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
        CardViewMain.id: (context) => CardViewMain(),
        EditCardset.id: (context) => EditCardset(),
        EditCardsetScratch.id: (context) => EditCardsetScratch(),
      },
    );
  }
}
