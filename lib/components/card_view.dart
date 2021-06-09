import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:flip_card/flip_card.dart';

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
    return Container(
        decoration: BoxDecoration(
            color: kSecondCardText, borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            FlipCard(
              direction: FlipDirection.HORIZONTAL, // default
              front: Container(
                height: 50,
                child: Text(cardPrimary, style: kCardsetCards),
              ),
              back: Container(
                height: 50,
                child: Text(cardSecondary, style: kCardsetBackCards),
              ),
            ),
          ],
        ));
  }
}
