import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:flip_card/flip_card.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/helpers/cardset_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

class CardViewCard extends StatefulWidget {
  static String id = 'card_sets_view';

  CardViewCard({required this.cardsetID});

  final String cardsetID;
  // final String cardID;
  // final String cardPrimary;
  // final String cardSecondary;
  // final String cardCategory;

  @override
  _CardViewCardState createState() => _CardViewCardState();
}

class _CardViewCardState extends State<CardViewCard> {
  User? loggedInUser;
  final uFunctions = UserFunctions();

  CardsetFunctions cFunctions = CardsetFunctions();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: cFunctions.generateCardView(widget.cardsetID),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(child: Center(child: Text("Loading...")));
          } else {
            print('Flip: ${snapshot.data}');
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    decoration: BoxDecoration(
                        color: kSecondCardText,
                        borderRadius: BorderRadius.circular(10.0)),
                    margin: EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        FlipCard(
                          direction: FlipDirection.HORIZONTAL, // default
                          front: Container(
                            height: 50,
                            child: Text(snapshot.data[index]['primary_word'],
                                style: kCardsetCards),
                          ),
                          back: Container(
                            height: 50,
                            child: Text(snapshot.data[index]['secondary_word'],
                                style: kCardsetBackCards),
                          ),
                        ),
                      ],
                    ));

                //   CardViewCard(
                //   cardID: snapshot.data[index].cardID,
                //   cardPrimary: snapshot.data[index].cardPrimary,
                //   cardSecondary: snapshot.data[index].cardSecondary,
                //   cardCategory: snapshot.data[index].cardCategory,
                // );
              },
            );
          }
        },
      ),
    );
  }
}
