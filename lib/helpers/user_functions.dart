import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/helpers/JWTGenerator.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mylearningcards_v1/helpers/auth_with_email.dart';
import 'dart:convert';

class UserFunctions {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  User? getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final User loggedInUser = user;
        print(loggedInUser.displayName);
        return user;
      } else {
        print('User is null');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> getLoggedIn() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final User loggedInUser = user;
        print(loggedInUser.displayName);
        return true;
      } else {
        print('User is null');
      }
    } catch (e) {
      print(e);
      return false;
    }

    return false;
  }

  void loginUser(String userId) async {
    final user = _auth.currentUser;
    var body = "";

    print('LoginID: $userId');
    var token = JWTGenerator.createJWT(userId);

    body = jsonEncode(<String, String>{'uid': userId});
    print("body $body");
    try {
      http.Response response = await http.post(
        Uri.parse('$cardsAPI/loginuser'),
        // Send authorization headers to the backend.
        headers: {
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
        },
        body: body,
      );
      print('${Uri.parse('$cardsAPI/loginuser')} ${response.statusCode}');
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signUpUser(String userEmail, String userPassword) async {
    final AuthWithEmail fAuthEmail = AuthWithEmail();

    //Signup user with firebase.  Process also logs user in.
    await fAuthEmail.signUp(email: userEmail, password: userPassword);

    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

    bool userCreated = false;
    String uid = "";
    String display_name = "";
    String photo_url = "";
    String providerId = "";
    String email = "";
    var token = "";
    var body = "";

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

    //Post user information to webservices and create user
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

    //Login user
    try {
      loginUser(uid);
      userCreated = true;
    } catch (e) {
      print(e);
    }
    return userCreated;
  }

  Future<Null> signOutWithGoogle() async {
    // Sign out with firebase
    await _auth.signOut();
    // Sign out with google
    await googleSignIn.signOut();
  }
}
