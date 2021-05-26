import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyLearningCards'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Image.asset('images/mylearningcards_logo.png'),
          ),
          Expanded(
            child: Text('My Learning Cards'),
          ),
          Expanded(
            child: Text(
              //TODO: Add firebase auth widget
              'FirebaseAuth Widget',
            ),
          )
        ],
      ),
    );
  }
}
