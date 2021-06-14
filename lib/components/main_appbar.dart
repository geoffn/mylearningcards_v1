import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/pages/welcome_main_screen.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('MyLearningCards', style: kAppBar),
      backgroundColor: kSecondCardText,
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, WelcomeMain.id);
          },
          icon: Icon(Icons.home),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
