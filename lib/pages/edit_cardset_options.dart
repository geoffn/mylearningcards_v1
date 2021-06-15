import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/pages/add_created_card_screen.dart';
import 'package:mylearningcards_v1/pages/edit_add_new_card_screen.dart';
import 'package:mylearningcards_v1/pages/remove_assigned_card_screen.dart';
import 'package:mylearningcards_v1/components/cardset_banner.dart';
import 'package:mylearningcards_v1/components/main_appbar.dart';

class EditCardsetOptions extends StatefulWidget {
  static String id = 'editcardsetoptions_screen';

  @override
  _EditCardsetOptionsState createState() => _EditCardsetOptionsState();
}

class _EditCardsetOptionsState extends State<EditCardsetOptions> {
  User? loggedInUser;
  final uFunctions = UserFunctions();
  String cardsetID = "";

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
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: kSecondCardText,
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Create a new card and assign it to the current card set.  If you have already created the card or are using a card from a different card set then you can add and existing card below.",
                      style: kCardsetDataSmall,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kButtonColor),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, EditAddNewCard.id,
                            arguments: cardsetID);
                      },
                      child: const Text('Add New Card'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: kSecondCardText,
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Add an existing card to this card set.",
                      style: kCardsetDataSmall,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kButtonColor),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AddCreatedCard.id,
                            arguments: cardsetID);
                      },
                      child: const Text('Add Existing Card'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: kSecondCardText,
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Remove a card from the current card set.",
                      style: kCardsetDataSmall,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kButtonColor),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RemoveAssignedCard.id,
                            arguments: cardsetID);
                      },
                      child: const Text('Remove Card'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
