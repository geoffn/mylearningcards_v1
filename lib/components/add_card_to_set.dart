//TODO:  Add and existing card to this set.  Create list of available cards.  Add search for cards

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/helpers/cardset_functions.dart';

class AddCardToSet extends StatefulWidget {
  AddCardToSet({required this.cardsetID, required this.searchTerm});
  final String cardsetID;
  final String searchTerm;

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
                FutureBuilder(
                  future: cFunctions.generateAvailalbeCards(widget.searchTerm),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    var childCount = 0;
                    if (snapshot.connectionState != ConnectionState.done ||
                        snapshot.data == null)
                      childCount = 1;
                    else {
                      childCount = snapshot.data.length;
                      print('avail: ${snapshot.data[0]}');
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          //todo handle state
                          return CircularProgressIndicator(); //todo set progress bar
                        }
                        if (snapshot.hasData == false) {
                          return Container();
                        }

                        return Card(
                          margin: EdgeInsets.fromLTRB(30, 3, 30, 3),
                          color: cardColor,
                          child: new ListTile(
                            leading: GestureDetector(
                                onTap: () async {
                                  print("icon tapped");
                                  print(
                                      "id of card: ${snapshot.data[index]['_id']} for cardset ${widget.cardsetID}");
                                  cFunctions.addCardToCardsetFunction(
                                      widget.cardsetID,
                                      snapshot.data[index]['_id']);
                                  setState(() {
                                    cardColor = kSecondCardText;
                                  });
                                },
                                child: Icon(Icons.add)),
                            title: new Text(
                                snapshot.data[index]['primary_word'],
                                style: new TextStyle(color: Colors.white)),
                          ),
                        );
                      }, childCount: childCount),
                    );
                  },
                ),
              ]),
            )
          ]),
    );
  }
}
