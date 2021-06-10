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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddNewCard.id,
                    arguments: cardsetID);
              },
              child: const Text('Add New Card'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddCreatedCard.id,
                    arguments: cardsetID);
              },
              child: const Text('Add Existing Card'),
            ),
            const SizedBox(height: 30),
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
    );
  }
}
