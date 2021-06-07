import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mylearningcards_v1/components/card_set.dart';
import 'package:mylearningcards_v1/components/oauth.dart';
import 'package:mylearningcards_v1/constants.dart';
import '../components/card_sets_view.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/pages/welcome_cards.dart';
import 'package:mylearningcards_v1/components/main_drawer.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      final user = _auth.currentUser;
      if (user != null) {
        //Navigator.pushNamed(context, CardsetViewCard.id);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyLearningCards', style: kCardsetCards),
        backgroundColor: kSecondCardText,
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Material(
              elevation: 5.0,
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () async {
                  try {
                    final user = await AuthWithGoogle.signInWithGoogle();
                    if (user != null) {
                      print(user.user);
                    }
                    Navigator.pushNamed(context, WelcomeMain.id);
                  } catch (e) {
                    print(e);
                  }
                },
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
