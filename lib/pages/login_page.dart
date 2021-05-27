import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'card_sets_view.dart';
import 'package:mylearningcards_v1/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: kSecondCardText,
              ),
              child: Image.asset('images/mylearningcards_logo.png'),
            ),
          ),
          Expanded(
            child: Text(
              'My Learning Cards',
              textAlign: TextAlign.center,
              style: kTitleTextStyle,
            ),
          ),
          Expanded(
            child: Text(
              //TODO: Add firebase auth widget
              'FirebaseAuth Widget', textAlign: TextAlign.center,
              style: kTitleTextStyle,
            ),
          ),
          Expanded(
            child: CardsetViewCard(
              cardsetName: 'Spanish 101',
              cardsetDescription: 'Spanish 101 card set',
              cardsetCreateDate: '05/25/21',
              cardsetAccessedCount: 5,
              cardsetCardCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}
