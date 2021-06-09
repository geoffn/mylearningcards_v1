//TODO: add form and add cards to owners cards and add to current card list.dynamic
import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/components/jwt.dart';
import 'dart:convert';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'package:mylearningcards_v1/pages/welcome_cards.dart';

class NewCardset extends StatefulWidget {
  static String id = 'AddNewCard';

  NewCardset();

  @override
  _NewCardsetState createState() => _NewCardsetState();
}

class _NewCardsetState extends State<NewCardset> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String userName = "";
  String userEmail = "";
  String userPicture = "";
  String frontCard = "";
  String backCard = "";
  String category = "NA";
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
      'primary_word': frontCard,
      'secondary_word': backCard,
      'category': category,
      'uid': newID != null ? newID : '0',
    });
    print("body $body");

    try {
      http.Response response = await http.post(
        Uri.parse('$cardsAPI/card'),
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
    return Container(
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
                    Text('Create New Card', style: kCardsetCards),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Front of Card', style: kCardsetCards),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 300,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            frontCard = value;
                            // print('CardSetName $cardsetName');
                          });
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            frontCard = value;
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
                          helperText: 'Front of Card *',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Back of Card', style: kCardsetCards),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 300,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            backCard = value;
                            //  print('CardSetDescription $cardsetDescription');
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            backCard = value != null ? value : "";
                            // print('CardSetDescription $cardsetDescription');
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          helperText: 'Back of Card *',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Category', style: kCardsetCards),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 300,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            category = value;
                            //  print('CardSetDescription $cardsetDescription');
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            category = value != null ? value : "";
                            // print('CardSetDescription $cardsetDescription');
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          helperText: 'Category',
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
    );
  }
}
