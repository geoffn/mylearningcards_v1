import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewCardset extends StatefulWidget {
  static String id = 'NewCardSet';
  @override
  _NewCardsetState createState() => _NewCardsetState();
}

class _NewCardsetState extends State<NewCardset> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String userName = "";
  String userEmail = "";
  String userPicture = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      final user = _auth.currentUser;
      if (user != null) {
        userName = user.providerData[0].displayName ?? "Missing";
        userEmail = user.providerData[0].email ?? "Missing";
        userPicture = user.providerData[0].photoURL ?? "Missing";
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
      drawer: new MainDrawer(
          userName: userName, userEmail: userEmail, userPicture: userPicture),
      body: Container(
        decoration: BoxDecoration(
            color: kSecondCardText, borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Card Set Name', style: kCardsetCards),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            helperText: 'Card Set Name',
                            counterText: '0 characters',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Card Set Description', style: kCardsetCards),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            helperText: 'Card Set Name',
                            counterText: '0 characters',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
