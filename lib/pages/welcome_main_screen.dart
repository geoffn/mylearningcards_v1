import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/card_sets_view.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/components/jwt.dart';
import 'dart:convert';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:mylearningcards_v1/pages/new_cardset.dart';
import 'package:mylearningcards_v1/components/main_appbar.dart';
import 'package:mylearningcards_v1/helpers/shared_preferences_functions.dart';

class WelcomeMain extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeMainState createState() => _WelcomeMainState();
}

class _WelcomeMainState extends State<WelcomeMain> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  final uFunctions = UserFunctions();
  String userName = "";
  String userEmail = "";
  String userPicture = "";
  final spFunctions = SharedPreferencesFunction();

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

  Future<List<CardsetViewCard>> _generateCardsetView() async {
    final loggedInUser = uFunctions.getCurrentUser();
    String? newID = "";
    //print('LoggedIn: $loggedInUser');
    if (loggedInUser != null) {
      if (loggedInUser.providerData[0].uid != null) {
        newID = loggedInUser.providerData[0].uid != null
            ? loggedInUser.providerData[0].uid
            : '0';
      }
    }

    var token = JWTGenerator.createJWT(newID);

    http.Response response = await http.get(
      Uri.parse('$cardsAPI/cardsetforowner'),
      // Send authorization headers to the backend.
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    //print(response.statusCode);
    //print(response.body);

    var cardDataResults = json.decode(response.body);

    var cardData = cardDataResults["results"];

    //print('cardData: $cardData');

    List<CardsetViewCard> cardsets = [];

    for (var card in cardData) {
      CardsetViewCard cardset = CardsetViewCard(
          cardsetID: card["_id"],
          cardsetName: card["set_name"],
          cardsetDescription: card["set_description"],
          cardsetCreateDate: card["createdAt"],
          cardsetAccessedCount: card["access_count"],
          cardsetCardCount: card["cards"].length);
      //print("In For Loop");
      cardsets.add(cardset);
      spFunctions.setCardName(card["_id"], card["set_name"]);
      //print(card["set_name"]);
    }

    return cardsets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MainAppBar(),
      drawer: new MainDrawer(
          userName: userName, userEmail: userEmail, userPicture: userPicture),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: _generateCardsetView(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(child: Center(child: Text("Loading...")));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardsetViewCard(
                            cardsetID: snapshot.data[index].cardsetID,
                            cardsetName: snapshot.data[index].cardsetName,
                            cardsetDescription:
                                snapshot.data[index].cardsetDescription,
                            cardsetCreateDate:
                                snapshot.data[index].cardsetCreateDate,
                            cardsetAccessedCount:
                                snapshot.data[index].cardsetAccessedCount,
                            cardsetCardCount:
                                snapshot.data[index].cardsetCardCount);
                      },
                    );
                  }
                },
              ),
            ),
          ]),
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
