//TODO:  Remove a card from the current set
import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylearningcards_v1/helpers/cardset_functions.dart';

class RemoveCardFromSet extends StatefulWidget {
  RemoveCardFromSet({required this.cardsetID});
  String cardsetID;

  @override
  _RemoveCardFromSetState createState() => _RemoveCardFromSetState();
}

class _RemoveCardFromSetState extends State<RemoveCardFromSet> {
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
            child: CustomScrollView(
              slivers: <Widget>[
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
                      'Assigned Cards',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: cFunctions.generateCardView(widget.cardsetID),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //                Whether project = projectSnap.data[index]; //todo check your model
                    var childCount = 0;
                    if (snapshot.connectionState != ConnectionState.done ||
                        snapshot.data == null)
                      childCount = 1;
                    else
                      childCount = snapshot.data.length;
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
                                      "id of card: ${snapshot.data[index].cardID} for cardset ${widget.cardsetID}");
                                  cFunctions.removeCardFromCardsetFunction(
                                      widget.cardsetID,
                                      snapshot.data[index].cardID);
                                  setState(() {
                                    cardColor = kSecondCardText;
                                  });
                                },
                                child: Icon(Icons.delete)),
                            title: new Text(snapshot.data[index].cardPrimary,
                                style: new TextStyle(color: Colors.white)),
                          ),
                        );
                      }, childCount: childCount),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}