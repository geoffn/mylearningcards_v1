import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:email_validator/email_validator.dart';

class RegisterUserWithEmail extends StatefulWidget {
  static String id = 'register_user_with_email';

  @override
  _RegisterUserWithEmailState createState() => _RegisterUserWithEmailState();
}

class _RegisterUserWithEmailState extends State<RegisterUserWithEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userEmail = "";
  String userPassword = "";
  String userPasswordConfirm = "";

  void _registerUsersEmail() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyLearningCards', style: kCardsetCards),
        backgroundColor: kSecondCardText,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: kSecondCardText, borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Register', style: kCardsetCards),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Email *', style: kCardsetDataSmall),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 300,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              userEmail = value;
                              // print('CardSetName $cardsetName');
                            });
                          },
                          onFieldSubmitted: (value) {
                            setState(() {
                              userEmail = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid email';
                            } else {
                              final bool emailValidated =
                                  EmailValidator.validate(value);
                              if (!emailValidated) {
                                return 'Please enter a valid email';
                              }
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Password *', style: kCardsetDataSmall),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 300,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              userPassword = value;
                              //  print('CardSetDescription $cardsetDescription');
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              userPassword = value != null ? value : "";
                              // print('CardSetDescription $cardsetDescription');
                            });
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Confirm Password*', style: kCardsetDataSmall),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 300,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              userPasswordConfirm = value;
                              //  print('CardSetDescription $cardsetDescription');
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              userPasswordConfirm = value != null ? value : "";
                              // print('CardSetDescription $cardsetDescription');
                            });
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kButtonColor),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _registerUsersEmail();
                            }
                          },
                          child: Text("Submit"),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
