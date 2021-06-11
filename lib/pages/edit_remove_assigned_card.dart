//TODO: Called from edit_cardset_ooptions.  List of cards with a delete icon.  Removes card from cardset
import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/components/remove_card_from_set.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/helpers/cardset_functions.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RemoveAssignedCard extends StatefulWidget {
  static String id = 'edit_remove_assigned_card';

  @override
  _RemoveAssignedCardState createState() => _RemoveAssignedCardState();
}

class _RemoveAssignedCardState extends State<RemoveAssignedCard> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  final uFunctions = UserFunctions();
  String userName = "";
  String userEmail = "";
  String userPicture = "";
  String cardsetID = "";
  CardsetFunctions cFunctions = CardsetFunctions();

  void initState() {
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
        title: Text('MyLearningCards S', style: kCardsetCards),
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
                bottom: 10,
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
            RemoveCardFromSet(cardsetID: cardsetID),
          ],
        ),
      ),
    );
  }
}
