import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/card_sets_view.dart';

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
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final User loggedInUser = user;
        print(loggedInUser.displayName);
        if (loggedInUser != null) {}
      } else {
        print('User is null');
      }
    } catch (e) {
      print(e);
    }

    print('gotuser');
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
