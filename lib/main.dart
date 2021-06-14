import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/pages/card_view_main_screen.dart';
import 'package:mylearningcards_v1/pages/add_created_card_screen.dart';
import 'package:mylearningcards_v1/pages/edit_add_new_card_screen.dart';
import 'package:mylearningcards_v1/pages/edit_cardset_screen.dart';
import 'package:mylearningcards_v1/pages/edit_cardset_options.dart';
import 'package:mylearningcards_v1/pages/remove_assigned_card_screen.dart';
import 'package:mylearningcards_v1/pages/new_cardset.dart';
import 'package:mylearningcards_v1/pages/welcome_main_screen.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mylearningcards_v1/pages/auth_check_redirect.dart';

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
      home: AuthCheckRedirect(),
      routes: {
        AuthCheckRedirect.id: (context) => AuthCheckRedirect(),
        LoginPage.id: (context) => LoginPage(),
        WelcomeMain.id: (context) => WelcomeMain(),
        NewCardset.id: (context) => NewCardset(),
        CardViewMain.id: (context) => CardViewMain(),
        EditCardset.id: (context) => EditCardset(),
        EditCardsetOptions.id: (context) => EditCardsetOptions(),
        EditAddNewCard.id: (context) => EditAddNewCard(),
        AddCreatedCard.id: (context) => AddCreatedCard(),
        RemoveAssignedCard.id: (context) => RemoveAssignedCard(),
      },
    );
  }
}
