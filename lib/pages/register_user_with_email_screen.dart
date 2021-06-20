import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/components/main_appbar.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mylearningcards_v1/helpers/auth_with_email.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mylearningcards_v1/helpers/JWTGenerator.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'package:mylearningcards_v1/pages/auth_check_redirect.dart';

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

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  void _registerUsersEmail() async {
    final AuthWithEmail fAuthEmail = AuthWithEmail();
    final UserFunctions uFunctions = UserFunctions();

    //register user with firebase
    await fAuthEmail.signUp(email: userEmail, password: userPassword);

    //Store user info in mongo
    var token = "";
    var body = "";
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    String uid = "";
    String display_name = "";
    String photo_url = "";
    String providerId = "";
    String email = "";

    if (user != null) {
      print('LoginID: ${user.providerData[0].uid}');

      token = JWTGenerator.createJWT(user.providerData[0].uid);
      uid = user.providerData[0].uid ?? "";
      display_name = user.providerData[0].displayName ?? "";
      photo_url = user.providerData[0].photoURL ?? "";
      providerId = user.providerData[0].providerId;
      email = user.providerData[0].email ?? "";

      if (user.providerData[0].email != null &&
          user.providerData[0].uid != null) {
        body = jsonEncode(<String, String>{
          'uid': uid,
          'display_name': display_name,
          'photo_url': photo_url,
          'provider': providerId,
          'email': email
        });
        print("body $body");
      }
    }
    try {
      http.Response response = await http.post(
        Uri.parse('$cardsAPI/user'),
        // Send authorization headers to the backend.
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: body,
      );
    } catch (e) {
      print(e);
    }

    try {
      String uriEncoded = Uri.encodeFull('$cardsAPI/loginuser/$uid');
      http.Response response = await http.post(
        Uri.parse(uriEncoded),
        // Send authorization headers to the backend.
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print('$cardsAPI/loginuser/$uid ${response.statusCode}');
    } catch (e) {
      print(e);
    }
    //Redirect to authredirect

    Navigator.pushReplacementNamed(context, AuthCheckRedirect.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
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
                          validator: EmailValidator(
                              errorText: 'enter a valid email address'),
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
                          obscureText: true,
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
                          validator: passwordValidator,
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
                          obscureText: true,
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
                          validator: (value) => MatchValidator(
                                  errorText: 'passwords do not match')
                              .validateMatch(userPasswordConfirm, userPassword),
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
