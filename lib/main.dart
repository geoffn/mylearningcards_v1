import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() => runApp(MyLearningCards());

class MyLearningCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        accentColor: Colors.purple,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),  
        ),
      ),
      home: LoginPage(),
    );
  }
}
