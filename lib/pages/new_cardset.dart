import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/helpers/JWTGenerator.dart';
import 'dart:convert';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'package:mylearningcards_v1/pages/welcome_main_screen.dart';
import 'package:mylearningcards_v1/components/main_appbar.dart';

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
  String cardsetName = "";
  String cardsetDescription = "";
  final uFunctions = UserFunctions();

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

  void _addCardSet() async {
    final loggedInUser = uFunctions.getCurrentUser();
    String? newID = "";
    print('LoggedIn: $loggedInUser');
    if (loggedInUser != null) {
      if (loggedInUser.providerData[0].uid != null) {
        newID = loggedInUser.providerData[0].uid != null
            ? loggedInUser.providerData[0].uid
            : '0';
      }
    }

    var token = JWTGenerator.createJWT(newID);

    var body = jsonEncode(<String, String>{
      'set_name': cardsetName,
      'set_description': cardsetDescription,
      'uid': newID != null ? newID : '0',
    });
    print("body $body");

    try {
      http.Response response = await http.post(
        Uri.parse('$cardsAPI/cardset'),
        // Send authorization headers to the backend.
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: body,
      );
      print(response.statusCode);
      Navigator.pushNamed(context, WelcomeMain.id);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MainAppBar(),
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
                          onChanged: (value) {
                            setState(() {
                              cardsetName = value;
                              // print('CardSetName $cardsetName');
                            });
                          },
                          onFieldSubmitted: (value) {
                            setState(() {
                              cardsetName = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            helperText: 'Card Set Name *',
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
                          onChanged: (value) {
                            setState(() {
                              cardsetDescription = value;
                              //  print('CardSetDescription $cardsetDescription');
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              cardsetDescription = value != null ? value : "";
                              // print('CardSetDescription $cardsetDescription');
                            });
                          },
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
                    children: [
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _addCardSet();
                            }
                          },
                          child: Text("Submit"),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
