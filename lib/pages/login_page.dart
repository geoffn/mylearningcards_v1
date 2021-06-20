import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mylearningcards_v1/helpers/auth_with_google.dart';
import 'package:mylearningcards_v1/constants.dart';
import 'package:mylearningcards_v1/pages/auth_check_redirect.dart';
import 'package:mylearningcards_v1/pages/register_user_with_email_screen.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user != null) {
      print('LOGIN: $user');
      //Navigator.pushReplacementNamed(context, WelcomeMain.id);
    }
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: kSecondCardText,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/mylearningcards_logo.png',
                    width: 200,
                    height: 200,
                  ),
                  Text('Mylearningcards.com')
                ],
              ),
            ),
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
                            Text('Sign in with Google')
                          ])),
                ),
              ],
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Container(
            //         padding: EdgeInsets.all(10.0),
            //         margin: EdgeInsets.all(10.0),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10.0),
            //           color: kSecondCardText,
            //         ),
            //         child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Image.asset(
            //                 'images/facebook.png',
            //                 width: 30,
            //                 height: 30,
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Text('Sign in with Facebook')
            //             ])),
            //   ],
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.pushReplacementNamed(
                        context, RegisterUserWithEmail.id);
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
                        Icon(
                          Icons.email,
                          color: Color(0xFFFFEE93),
                          size: 30.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Sign in with Email and Password')
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.pushReplacementNamed(
                        context, RegisterUserWithEmail.id);
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
                        Icon(
                          Icons.person_add,
                          color: Color(0xFFFFEE93),
                          size: 30.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('New User Registration')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
