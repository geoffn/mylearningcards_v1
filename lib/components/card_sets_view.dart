import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/pages/card_view_screen.dart';

class CardsetViewCard extends StatelessWidget {
  static String id = 'card_sets_view';
  CardsetViewCard(
      {required this.cardsetID,
      required this.cardsetName,
      required this.cardsetDescription,
      required this.cardsetCreateDate,
      required this.cardsetAccessedCount,
      required this.cardsetCardCount});

  final String cardsetID;
  final String cardsetName;
  final String cardsetDescription;
  final String cardsetCreateDate;
  final int cardsetAccessedCount;
  final int cardsetCardCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          Navigator.pushReplacementNamed(context, CardViewMain.id,
              arguments: cardsetID);
          print('Nav Send $cardsetID');

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
                    Text(cardsetName, style: kCardsetCards),
                  ],
                ),
                SizedBox(
                  width: 10,
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Text(cardsetDescription, style: kCardsetData),
                  ],
                ),
                SizedBox(
                  width: 10,
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Text(
                        'Cards : $cardsetCardCount    Accessed: $cardsetAccessedCount',
                        style: kCardsetData),
                  ],
                ),
              ],
            )));
  }
}
