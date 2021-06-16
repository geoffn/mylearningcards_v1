import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylearningcards_v1/helpers/cardset_functions.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/card_view_card.dart';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:mylearningcards_v1/pages/edit_cardset_options.dart';
import 'package:mylearningcards_v1/components/main_appbar.dart';
import 'package:mylearningcards_v1/components/cardset_banner.dart';
import 'package:mylearningcards_v1/pages/edit_add_new_card_screen.dart';

class CardViewMain extends StatefulWidget {
  static String id = 'cardview_screen';

  @override
  _CardViewMainState createState() => _CardViewMainState();
}

class _CardViewMainState extends State<CardViewMain> {
  User? loggedInUser;
  final uFunctions = UserFunctions();
  String cardsetID = "";
  CardsetFunctions cFunctions = CardsetFunctions();

  @override
  Widget build(BuildContext context) {
    ModalRoute? route = ModalRoute.of(context);
    if (route != null) {
      final map = route.settings.arguments;
      print('PassedCardSetID $map');
      cardsetID = map.toString();
    }

    return Scaffold(
      appBar: new MainAppBar(),
      drawer: new MainDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CardSetBanner(),
              CardViewCard(cardsetID: cardsetID),
            ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacementNamed(context, EditAddNewCard.id,
              arguments: cardsetID);
        },
        label: const Text('Edit Set'),
        icon: const Icon(Icons.edit),
        backgroundColor: kButtonColor,
      ),
    );
  }
}
