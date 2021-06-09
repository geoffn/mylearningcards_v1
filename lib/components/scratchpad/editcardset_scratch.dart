import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/components/add_new_cards.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mylearningcards_v1/components/main_drawer.dart';
import 'package:mylearningcards_v1/helpers/cardset_functions.dart';
import 'package:mylearningcards_v1/components/card_view.dart';

class EditCardsetScratch extends StatefulWidget {
  static String id = 'editcardset_scratch';

  @override
  _EditCardsetScratchState createState() => _EditCardsetScratchState();
}

class _EditCardsetScratchState extends State<EditCardsetScratch> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  final uFunctions = UserFunctions();
  String userName = "";
  String userEmail = "";
  String userPicture = "";
  String cardsetID = "";
  CardsetFunctions cFunctions = CardsetFunctions();

  @override
  void initState() {
    super.initState();
    try {
      final user = _auth.currentUser;
      if (user != null) {
        userName = user.providerData[0].displayName ?? "Missing";
        userEmail = user.providerData[0].email ?? "Missing";
        userPicture = user.providerData[0].photoURL ?? "Missing";
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    ModalRoute? route = ModalRoute.of(context);
    if (route != null) {
      final map = route.settings.arguments;
      print('PassedCardSetID $map');
      cardsetID = map.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('MyLearningCards S', style: kCardsetCards),
        backgroundColor: kSecondCardText,
      ),
      drawer: new MainDrawer(
          userName: userName, userEmail: userEmail, userPicture: userPicture),
      body: Column(children: <Widget>[
        NewCardset(),
        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: CustomScrollView(slivers: <Widget>[
                    SliverAppBar(
                      iconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.red,
                      expandedHeight: 100,
                      pinned: true,
                      floating: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          'Assigned Cards',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: cFunctions.generateCardView(cardsetID),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          //                Whether project = projectSnap.data[index]; //todo check your model
                          var childCount = 0;
                          if (snapshot.connectionState !=
                                  ConnectionState.done ||
                              snapshot.data == null)
                            childCount = 1;
                          else
                            childCount = snapshot.data.length;
                          return SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                //todo handle state
                                return CircularProgressIndicator(); //todo set progress bar
                              }
                              if (snapshot.hasData == false) {
                                return Container();
                              }
                              return Card(
                                margin: EdgeInsets.fromLTRB(30, 3, 30, 3),
                                color: Colors.black12,
                                child: new ListTile(
                                  leading: Icon(Icons.delete),
                                  title: new Text(
                                      snapshot.data[index].cardPrimary,
                                      style:
                                          new TextStyle(color: Colors.white)),
                                ),
                              );
                            }, childCount: childCount),
                          );
                        }),
                    SliverAppBar(
                      iconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.red,
                      expandedHeight: 100,
                      pinned: true,
                      floating: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          'Available Cards',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          child: FutureBuilder(
                            future: cFunctions.generateCardView(cardsetID),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                    child: Center(child: Text("Loading...")));
                              } else
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext content, int index) {
                                      return snapshot.hasData
                                          ? Card(
                                              child: ListTile(
                                                  title: Text(snapshot
                                                      .data[index]
                                                      .cardPrimary)),
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
              ]),
        ),
      ]),
    );
  }

  Card _buildListItem(String primaryWord, String cardId) {
    return Card(
      margin: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 10, top: 0),
              child: Text(
                primaryWord,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
