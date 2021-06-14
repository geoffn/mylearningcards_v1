//TODO: search and then list of cards to add to this cardset.dynamic
import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/components/cardset_banner.dart';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/helpers/cardset_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylearningcards_v1/components/add_card_to_set.dart';
import 'package:mylearningcards_v1/components/search_available_cards.dart';
import 'package:mylearningcards_v1/components/main_appbar.dart';

class AddCreatedCard extends StatefulWidget {
  static String id = 'edit_add_created_card';

  @override
  _AddCreatedCardState createState() => _AddCreatedCardState();
}

class _AddCreatedCardState extends State<AddCreatedCard> {
  User? loggedInUser;
  final uFunctions = UserFunctions();
  String cardsetID = "";
  String searchTerm = "";
  CardsetFunctions cFunctions = CardsetFunctions();

  @override
  Widget build(BuildContext context) {
    ModalRoute? route = ModalRoute.of(context);
    if (route != null) {
      final map = route.settings.arguments;
      print('PassedCardSetID $map');
      if (map.toString().contains('/')) {
        var tempString = map.toString().replaceFirst('{', '');
        tempString = tempString.replaceFirst('}', '');
        var searchParam = tempString.split('/');
        cardsetID = searchParam[0];
        searchTerm = searchParam[1];
      } else {
        cardsetID = map.toString();
      }
      print('cardsetid $cardsetID');
      print('searchterm $searchTerm');
    }

    return Scaffold(
      appBar: new MainAppBar(),
      drawer: new MainDrawer(),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardSetBanner(),
            SearchAvailableCards(cardsetID: cardsetID),
            AddCardToSet(cardsetID: cardsetID, searchTerm: searchTerm),
          ],
        ),
      ),
    );
  }
}
