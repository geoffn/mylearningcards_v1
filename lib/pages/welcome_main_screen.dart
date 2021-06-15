import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/cardset_view_card.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/helpers/JWTGenerator.dart';
import 'dart:convert';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:mylearningcards_v1/pages/new_cardset.dart';
import 'package:mylearningcards_v1/components/main_appbar.dart';
import 'package:mylearningcards_v1/components/search_cardsets.dart';

class WelcomeMain extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeMainState createState() => _WelcomeMainState();
}

class _WelcomeMainState extends State<WelcomeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MainAppBar(),
      drawer: new MainDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SearchCardsets(),
          CardsetViewCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, NewCardset.id);
        },
        label: const Text('Add Card Set'),
        icon: const Icon(Icons.add),
        backgroundColor: kButtonColor,
      ),
    );
  }
}
