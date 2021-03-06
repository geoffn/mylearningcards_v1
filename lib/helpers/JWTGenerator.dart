import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/conf/conf_dev.dart';

class JWTGenerator {
  static String createJWT(String? userId) {
// Create a json web token
    //print('UserId for JWT: $userId');
    final jwt = JWT(
      {
        'uid': userId,
      },
      issuer: 'https://github.com/jonasroussel/jsonwebtoken',
    );

// Sign it (default with HS256 algorithm)
    var token = jwt.sign(SecretKey(secretJWTKey));

    //print('Signed token: $token\n');
    return token;
  }

  void callUsers() async {
    var token = createJWT("434343");

    http.Response response = await http.get(
      Uri.parse('$cardsAPI/users'),
      // Send authorization headers to the backend.
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    //print(response.statusCode);
    //print(response.body);
  }
}
