import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/helpers/cardset_functions.dart';
import 'package:mylearningcards_v1/helpers/shared_preferences_functions.dart';

class CardSetBanner extends StatefulWidget {
  String cardsetID = "";
  String cardsetName = "";
  @override
  _CardSetBannerState createState() => _CardSetBannerState();
}

class _CardSetBannerState extends State<CardSetBanner> {
  Future<String> _getCurrentName() async {
    final SharedPreferencesFunction spFunctions = SharedPreferencesFunction();

    Map cardMap = await spFunctions.getCurrentCardset();
    print('BannerCardMap $cardMap');
    print('$kCurrentCardsetNameLabel ${cardMap['CurrentCardsetName']}');
    return cardMap['$kCurrentCardsetNameLabel'] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 5,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kSecondCardText,
      ),
      child: Center(
        child: FutureBuilder<String>(
            future:
                _getCurrentName(), // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                print('HasData ${snapshot.data}');
                children = <Widget>[
                  Text(
                    'Cardset: ${snapshot.data}',
                    style: kCardsetData,
                  )
                ];
              } else {
                children = <Widget>[
                  Text(
                    'Cardset',
                    style: kCardsetData,
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              );
            }),
      ),
    );
  }
}
