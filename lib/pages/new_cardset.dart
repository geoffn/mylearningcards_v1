import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/components/main_drawer.dart';

class NewCardset extends StatefulWidget {
  static String id = 'NewCardSet';
  @override
  _NewCardsetState createState() => _NewCardsetState();
}

class _NewCardsetState extends State<NewCardset> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyLearningCards', style: kCardsetCards),
        backgroundColor: kSecondCardText,
      ),
      drawer: MainDrawer(),
      body: Container(
        decoration: BoxDecoration(
            color: kSecondCardText, borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 100,
                child: Row(
                  children: <Widget>[
                    Text('Card Set Name', style: kCardsetCards),
                    TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.send),
                        hintText: 'Hint Text',
                        helperText: 'Helper Text',
                        counterText: '0 characters',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
