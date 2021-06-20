import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/components/main_appbar.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/pages/auth_check_redirect.dart';

class LoginWithEmail extends StatefulWidget {
  static String id = 'login_with_email';

  @override
  _LoginWithEmailState createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userEmail = "";
  String userPassword = "";
  String loginMessage = "";

  void _loginUsersEmail() async {
    final UserFunctions uFunctions = UserFunctions();

    bool userCreated = await uFunctions.signInUser(userEmail, userPassword);
    //register user with firebase
    //Redirect to authredirect
    if (userCreated) {
      print('User Signed In');
      Navigator.pushReplacementNamed(context, AuthCheckRedirect.id);
    } else {
      print('Failed Login');
      setState(() {
        loginMessage = "Invalid username or password";
      });
    }
  }

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
                      Text('Login', style: kCardsetCards),
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
                          //validator: passwordValidator,
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
                      Text(loginMessage, style: kCardsetDataSmall),
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
                              _loginUsersEmail();
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
