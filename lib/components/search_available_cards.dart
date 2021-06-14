import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/add_card_to_set.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/components/jwt.dart';
import 'dart:convert';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'package:mylearningcards_v1/pages/add_created_card_screen.dart';
import 'package:mylearningcards_v1/pages/welcome_main_screen.dart';

class SearchAvailableCards extends StatefulWidget {
  SearchAvailableCards({required this.cardsetID});

  String cardsetID;
  @override
  _SearchAvailableCardsState createState() => _SearchAvailableCardsState();
}

class _SearchAvailableCardsState extends State<SearchAvailableCards> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String searchTerm = "";

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
                    Text('Card Search', style: kCardsetCards),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 300,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            searchTerm = value;
                            // print('CardSetName $cardsetName');
                          });
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            searchTerm = value;
                          });
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter a search';
                        //   }
                        //   return null;
                        // },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          helperText: 'Search',
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
                            String args = '${widget.cardsetID}/$searchTerm';

                            Navigator.pushReplacementNamed(
                                context, AddCreatedCard.id,
                                arguments: {args});
                          }
                        },
                        child: Text("Search"),
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
