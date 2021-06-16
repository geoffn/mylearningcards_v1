//TODO: search and then list of cards to add to this cardset.dynamic
import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/components/add_new_card.dart';
import 'package:mylearningcards_v1/components/cardset_banner.dart';
import 'package:mylearningcards_v1/components/remove_card_from_set.dart';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/helpers/cardset_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylearningcards_v1/components/main_appbar.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/pages/add_created_card_screen.dart';

class EditAddNewCard extends StatefulWidget {
  static String id = 'edit_add_new_card';

  @override
  _EditAddNewCardState createState() => _EditAddNewCardState();
}

class _EditAddNewCardState extends State<EditAddNewCard> {
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
            AddNewCard(cardsetID: cardsetID),
            RemoveCardFromSet(cardsetID: cardsetID),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacementNamed(context, AddCreatedCard.id,
              arguments: cardsetID);
        },
        label: const Text('Add Existing Card'),
        icon: const Icon(Icons.edit),
        backgroundColor: kButtonColor,
      ),
    );
  }
}
