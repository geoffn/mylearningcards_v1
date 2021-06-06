import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mylearningcards_v1/components/user_functions.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/card_sets_view.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/components/jwt.dart';
import 'dart:convert';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:mylearningcards_v1/pages/new_cardset.dart';

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
  Future<List<CardsetViewCard>> _generateCardsetView() async {
    final loggedInUser = uFunctions.getCurrentUser();
    String? newID = "";
    print('LoggedIn: $loggedInUser');
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
    print(response.statusCode);
    print(response.body);

    var cardDataResults = json.decode(response.body);

    var cardData = cardDataResults["results"];

    print('cardData: $cardData');

    List<CardsetViewCard> Cardsets = [];

    for (var card in cardData) {
      CardsetViewCard cardset = CardsetViewCard(
          cardsetName: card["set_name"],
          cardsetDescription: card["set_description"],
          cardsetCreateDate: card["createdAt"],
          cardsetAccessedCount: card["access_count"],
          cardsetCardCount: card["cards"].length);
      print("In For Loop");
      Cardsets.add(cardset);
      print(card["set_name"]);
    }

    return Cardsets;
  }

  @override
  Widget build(BuildContext context) {
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
                future: _generateCardsetView(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(child: Center(child: Text("Loading...")));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () async {
                              print('Tap');

                              //callUsers();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: kSecondCardText,
                                    borderRadius: BorderRadius.circular(10.0)),
                                margin:
                                    EdgeInsets.only(top: 5, right: 5, left: 5),
                                child: Column(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(snapshot.data[index].cardsetName,
                                            style: kCardsetCards),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                            snapshot
                                                .data[index].cardsetDescription,
                                            style: kCardsetData),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                            'Cards : ${snapshot.data[index].cardsetCardCount}    Accessed: ${snapshot.data[index].cardsetAccessedCount}',
                                            style: kCardsetData),
                                      ],
                                    ),
                                  ],
                                )));
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
