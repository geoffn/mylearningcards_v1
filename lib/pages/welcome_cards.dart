import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final loggedInUser = getCurrentUser();
    print('LoggedIn: $loggedInUser');
    if (loggedInUser != null) {
      if (loggedInUser.providerData[0].uid != null) {
        var newID = loggedInUser.providerData[0].uid != null
            ? loggedInUser.providerData[0].uid
            : '0';
        generateCardsetView(newID);
      }
    }
  }

  User? getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final User loggedInUser = user;
        print(loggedInUser.displayName);
        return user;
      } else {
        print('User is null');
      }
    } catch (e) {
      print(e);
    }
  }

  void generateCardsetView(String? userId) async {
    var url = Uri.parse('$cardsAPI/cardsetforowner');
    var token = JWTGenerator.createJWT(userId);

    http.Response response = await http.get(
      Uri.parse('$cardsAPI/cardsetforowner'),
      // Send authorization headers to the backend.
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
    print(response.body);
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
              child: CardsetViewCard(
                  cardsetName: 'Spanish 101',
                  cardsetDescription: 'cardsetDescription',
                  cardsetCreateDate: '202010603',
                  cardsetAccessedCount: 4,
                  cardsetCardCount: 6)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              elevation: 5.0,
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () async {},
                minWidth: 200.0,
                height: 42.0,
                child: Text(
                  'Sign in With Google',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              elevation: 5.0,
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () {
                  //Go to login screen.
                  //Navigator.pushNamed(context, LoginScreen.id);
                },
                minWidth: 200.0,
                height: 42.0,
                child: Text(
                  'Log In',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(30.0),
              elevation: 5.0,
              child: MaterialButton(
                onPressed: () {
                  //Go to registration screen.
                  //Navigator.pushNamed(context, RegistrationScreen.id);
                },
                minWidth: 200.0,
                height: 42.0,
                child: Text(
                  'Register',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
