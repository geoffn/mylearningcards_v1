import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';

class CardViewCard extends StatelessWidget {
  static String id = 'card_sets_view';

  CardViewCard(
      {required this.cardID,
      required this.cardPrimary,
      required this.cardSecondary,
      required this.cardCategory});

  final String cardID;
  final String cardPrimary;
  final String cardSecondary;
  final String cardCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          print('Tap');

          //callUsers();
        },
        child: Container(
            decoration: BoxDecoration(
                color: kSecondCardText,
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(cardPrimary, style: kCardsetCards),
                  ],
                ),
                SizedBox(
                  width: 10,
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Text(cardSecondary, style: kCardsetData),
                  ],
                ),
                SizedBox(
                  width: 10,
                  height: 20,
                ),
              ],
            )));
  }
}
