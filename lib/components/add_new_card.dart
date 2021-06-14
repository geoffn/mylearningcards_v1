//TODO: add form and add cards to owners cards and add to current card list.dynamic
import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/helpers/JWTGenerator.dart';
import 'dart:convert';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';

class AddNewCard extends StatefulWidget {
  static String id = 'AddNewCard';

  AddNewCard({required this.cardsetID});

  final String cardsetID;

  @override
  _AddNewCardState createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userName = "";
  String userEmail = "";
  String userPicture = "";
  String frontCard = "";
  String backCard = "";
  String category = "NA";
  final uFunctions = UserFunctions();

  void _addCardSet() async {
    final loggedInUser = uFunctions.getCurrentUser();
    String newCardID = "";
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
      print(response.body);
      final Map newCardIDMap = json.decode(response.body);
      newCardID = newCardIDMap["_id"];
      print('newcardid: $newCardID');
    } catch (e) {}

    try {
      var addCardBody = jsonEncode(<String, String>{
        'cardId': newCardID,
        'cardSetId': widget.cardsetID,
        'category': category,
        'uid': newID != null ? newID : '0',
      });
      http.Response response = await http.post(
        Uri.parse('$cardsAPI/cardsetaddcard'),
        // Send authorization headers to the backend.
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: addCardBody,
      );
      print(response.statusCode);
      print(response.body);
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
                    Text('Front of Card *', style: kCardsetDataSmall),
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
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Back of Card *', style: kCardsetDataSmall),
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
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Category', style: kCardsetDataSmall),
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
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kButtonColor),
                        ),
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
