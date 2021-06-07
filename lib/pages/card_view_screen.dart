import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mylearningcards_v1/components/user_functions.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/card_view.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/components/jwt.dart';
import 'dart:convert';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:mylearningcards_v1/pages/new_cardset.dart';

class CardViewMain extends StatefulWidget {
  static String id = 'cardview_screen';

  @override
  _CardViewMainState createState() => _CardViewMainState();
}

class _CardViewMainState extends State<CardViewMain> {
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

  Future<List<CardViewCard>> _generateCardView(String CardsetID) async {
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
      Uri.parse('$cardsAPI/cardset/$CardsetID'),
      // Send authorization headers to the backend.
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
    //print(response.body);

    var cardDataResults = json.decode(response.body);
    print('CVS- $cardDataResults');
    var cardData = cardDataResults["results"][0];
    var allCards = cardData["cards"];

    List<CardViewCard> Cardsets = [];

    for (var card in allCards) {
      CardViewCard cardset = CardViewCard(
        cardID: card["_id"],
        cardPrimary: card["primary_word"],
        cardSecondary: card["secondary_word"],
        cardCategory: card["category"],
      );
      print("In For Loop");
      Cardsets.add(cardset);
      print(card["_id"]);
    }

    return Cardsets;
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
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: _generateCardView(cardsetID),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(child: Center(child: Text("Loading...")));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardViewCard(
                          cardID: snapshot.data[index].cardID,
                          cardPrimary: snapshot.data[index].cardPrimary,
                          cardSecondary: snapshot.data[index].cardSecondary,
                          cardCategory: snapshot.data[index].cardCategory,
                        );
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
        backgroundColor: kSecondCardText,
      ),
    );
  }
}
