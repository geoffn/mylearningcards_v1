import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer();

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    final UserFunctions uFunctions = new UserFunctions();

    String userName;
    String userEmail;
    String userPicture;
    if (user != null) {
      userName = user.providerData[0].displayName ?? "Missing";
      userEmail = user.providerData[0].email ?? "Missing";
      userPicture = user.providerData[0].photoURL ?? "Missing";
    } else {
      userName = "Missing";
      userEmail = "Missing";
      userPicture = "Missing";
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(userEmail),
            accountName: Text(userName),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(userPicture),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF11698E),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: GestureDetector(
                onTap: () async {
                  await uFunctions.signOutWithGoogle();
                  if (_auth.currentUser != null) {
                    print('User Still Logged In');
                  } else {
                    print('User Logged OUT');
                  }
                  Navigator.pushReplacementNamed(context, LoginPage.id);
                },
                child: Icon(Icons.account_circle)),
            title: Text(userName),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
