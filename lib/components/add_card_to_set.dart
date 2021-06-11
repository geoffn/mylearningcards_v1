//TODO:  Add and existing card to this set.  Create list of available cards.  Add search for cards

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/helpers/cardset_functions.dart';

class AddCardToSet extends StatefulWidget {
  AddCardToSet({required this.cardsetID});
  String cardsetID;

  @override
  _AddCardToSetState createState() => _AddCardToSetState();
}

class _AddCardToSetState extends State<AddCardToSet> {
  CardsetFunctions cFunctions = CardsetFunctions();

  Color cardColor = kSecondCardText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                iconTheme: IconThemeData(
                  color: kSecondCardText,
                ),
                backgroundColor: kSecondCardText,
                expandedHeight: 50,
                pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Available Cards',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    child: FutureBuilder(
                      future: cFunctions.generateAvailalbeCards(null),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Container(
                              child: Center(child: Text("Loading...")));
                        } else
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext content, int index) {
                                return snapshot.hasData
                                    ? Card(
                                        child: ListTile(
                                            title: Text(snapshot
                                                .data[index].cardPrimary)),
                                      )
                                    : Text('No Data');
                              });
                      },
                    ),
                  ),
                ]),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
