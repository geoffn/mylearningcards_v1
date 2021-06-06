import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer(
      {required this.userName,
      required this.userEmail,
      required this.userPicture});

  final String userName;
  final String userEmail;
  final String userPicture;

  @override
  Widget build(BuildContext context) {
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
            leading: Icon(Icons.account_circle),
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
