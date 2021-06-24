import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'package:mylearningcards_v1/pages/auth_check_redirect.dart';
import 'package:mylearningcards_v1/helpers/auth_with_google.dart';

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
    final UserFunctions uFunctions = UserFunctions();

    bool userCreated = await uFunctions.signUpUser(userEmail, userPassword);
    //register user with firebase
    //Redirect to authredirect
    if (userCreated) {
      print('User Created');
    }
    Navigator.pushReplacementNamed(context, AuthCheckRedirect.id);
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
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    try {
                      final user = await AuthWithGoogle.signInWithGoogle();
                      if (user != null) {
                        print(user.user);
                      }
                      Navigator.pushReplacementNamed(
                          context, AuthCheckRedirect.id);
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: kSecondCardText,
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/google.png',
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Register with Google')
                          ])),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: kSecondCardText,
                  borderRadius: BorderRadius.circular(10.0)),
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
                                    userPasswordConfirm =
                                        value != null ? value : "";
                                    // print('CardSetDescription $cardsetDescription');
                                  });
                                },
                                validator: (value) => MatchValidator(
                                        errorText: 'passwords do not match')
                                    .validateMatch(
                                        userPasswordConfirm, userPassword),
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
                                      MaterialStateProperty.all<Color>(
                                          kButtonColor),
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
          ],
        ),
      ),
    );
  }
}
