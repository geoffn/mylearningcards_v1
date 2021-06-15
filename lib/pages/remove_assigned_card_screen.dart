//TODO: Called from edit_cardset_ooptions.  List of cards with a delete icon.  Removes card from cardset
import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/components/remove_card_from_set.dart';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/helpers/cardset_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylearningcards_v1/components/cardset_banner.dart';
import 'package:mylearningcards_v1/components/main_appbar.dart';

class RemoveAssignedCard extends StatefulWidget {
  static String id = 'edit_remove_assigned_card';

  @override
  _RemoveAssignedCardState createState() => _RemoveAssignedCardState();
}

class _RemoveAssignedCardState extends State<RemoveAssignedCard> {
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
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardSetBanner(),
            RemoveCardFromSet(cardsetID: cardsetID),
          ],
        ),
      ),
    );
  }
}
