import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/helpers/shared_preferences_functions.dart';
import 'package:mylearningcards_v1/pages/card_view_main_screen.dart';
import 'package:mylearningcards_v1/helpers/cardset_functions.dart';

class CardsetViewCard extends StatefulWidget {
  static String id = 'card_sets_view';
  @override
  _CardsetViewCardState createState() => _CardsetViewCardState();
}

class _CardsetViewCardState extends State<CardsetViewCard> {
  final SharedPreferencesFunction spFunctions = SharedPreferencesFunction();
  final CardsetFunctions cFunctions = CardsetFunctions();
  String searchTerm = "";

  @override
  Widget build(BuildContext context) {
    ModalRoute? route = ModalRoute.of(context);
    if (route != null) {
      final map = route.settings.arguments;
      print('Search $map');

      searchTerm = map.toString();

      print('searchterm $searchTerm');
    }
    return Expanded(
        child: FutureBuilder(
            future: cFunctions.generateCardsetView(searchTerm),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print('Cardset ${snapshot.data}');
              if (snapshot.data == null) {
                return Container(child: Center(child: Text("Loading...")));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: kSecondCardText,
                          borderRadius: BorderRadius.circular(10.0)),
                      margin: EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () async {
                          //Set preferences CurrentCardSetID and CurrentCardSetName
                          spFunctions.setCurrentCardset(
                              snapshot.data[index]['_id'],
                              snapshot.data[index]['set_name']);
                          Navigator.pushReplacementNamed(
                              context, CardViewMain.id,
                              arguments: snapshot.data[index]['_id']);
                          print('Nav Send ${snapshot.data[index]['_id']}');
                        },
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(snapshot.data[index]['set_name'],
                                    style: kCardsetCards),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                              height: 20,
                            ),
                            Column(
                              children: <Widget>[
                                Text(snapshot.data[index]['set_description'],
                                    style: kCardsetData),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                              height: 20,
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                    'Cards : ${snapshot.data[index]['cards'].length}    Accessed: ${snapshot.data[index]['access_count']}',
                                    style: kCardsetData),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }));
  }
}
