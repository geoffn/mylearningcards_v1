import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylearningcards_v1/components/user_functions.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/card_sets_view.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/components/jwt.dart';
import 'dart:convert';

class WelcomeMain extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeMainState createState() => _WelcomeMainState();
}

class _WelcomeMainState extends State<WelcomeMain> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  final uFunctions = UserFunctions();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generateCardsetView();
  }

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
          cardsetCardCount: 0);
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF11698E),
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Color(0xFFFFEE93),
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
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
                      return Container(
                          child: Center(child: Text("Loading...")));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(snapshot.data[index].cardsetName),
                            subtitle:
                                Text(snapshot.data[index].cardsetDescription),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ]));
  }
}
