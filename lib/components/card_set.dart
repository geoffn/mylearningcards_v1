import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';

class CardSetCard extends StatelessWidget {
  CardSetCard(
      {required this.cardsetName,
      this.cardsetDescription,
      required this.cardsetCreateDate,
      required this.cardsetAccessedCount,
      required this.cardsetCardCount});

  final cardsetName;
  String? cardsetDescription;
  final String cardsetCreateDate;
  final int cardsetAccessedCount;
  final int cardsetCardCount;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: kSecondCardText,
              borderRadius: BorderRadius.circular(10.0),
            ),
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
                    Text(' $cardsetDescription', style: kCardsetData),
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
            ),
          ),
        ]);
  }
}
