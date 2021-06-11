import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/pages/edit_add_created_card.dart';
import 'package:mylearningcards_v1/pages/edit_add_new_card.dart';
import 'package:mylearningcards_v1/pages/edit_remove_assigned_card.dart';

class EditCardsetOptions extends StatefulWidget {
  static String id = 'editcardsetoptions_screen';

  @override
  _EditCardsetOptionsState createState() => _EditCardsetOptionsState();
}

class _EditCardsetOptionsState extends State<EditCardsetOptions> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  final uFunctions = UserFunctions();
  String userName = "";
  String userEmail = "";
  String userPicture = "";
  String cardsetID = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      final user = _auth.currentUser;
      if (user != null) {
        userName = user.providerData[0].displayName ?? "Missing";
        userEmail = user.providerData[0].email ?? "Missing";
        userPicture = user.providerData[0].photoURL ?? "Missing";
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    ModalRoute? route = ModalRoute.of(context);
    if (route != null) {
      final map = route.settings.arguments;
      print('PassedCardSetID $map');
      cardsetID = map.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('MyLearningCards', style: kCardsetCards),
        backgroundColor: kSecondCardText,
      ),
      drawer: new MainDrawer(
          userName: userName, userEmail: userEmail, userPicture: userPicture),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: kSecondCardText,
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Edit Card set Name",
                      style: kCardsetData,
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
                      "Create a new card and assign it to the current card set.  If you have already created the card or are using a card from a different card set then you can add and existing card below.",
                      style: kCardsetDataSmall,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddNewCard.id,
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
