import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/helpers/JWTGenerator.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

    print('LoginID: $userId');
    var token = JWTGenerator.createJWT(userId);
    try {
      http.Response response = await http.get(
        Uri.parse('$cardsAPI/loginuser/$userId'),
        // Send authorization headers to the backend.
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print('$cardsAPI/loginuser/$userId ${response.statusCode}');
    } catch (e) {
      print(e);
    }
  }

  void signUpUser(String email, String photoURL, String userID, String phone,
      String provider) {}

  Future<Null> signOutWithGoogle() async {
    // Sign out with firebase
    await _auth.signOut();
    // Sign out with google
    await googleSignIn.signOut();
  }
}
