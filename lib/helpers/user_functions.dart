import 'package:firebase_auth/firebase_auth.dart';

class UserFunctions {
  final _auth = FirebaseAuth.instance;

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
}
