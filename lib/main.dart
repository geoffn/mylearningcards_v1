import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() => runApp(MyLearningCards());

class MyLearningCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFC7FFD8),
        scaffoldBackgroundColor: Colors.white,
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
