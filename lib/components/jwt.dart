import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'dart:io';

//b11f795fff4ae42738c02299772e7afb58141330d09690d90e1bee4fcd964bbb7f657695cdd809e2c2088936ce60db9d324979237fb1bc55ed8d52594ff8d301
String createJWT() {
// Create a json web token
  final jwt = JWT(
    {
      'id': 123,
      'server': {
        'id': '3e4fc296',
        'loc': 'euw-2',
      }
    },
    issuer: 'https://github.com/jonasroussel/jsonwebtoken',
  );

// Sign it (default with HS256 algorithm)
  var token = jwt.sign(SecretKey(secretJWTKey));

  print('Signed token: $token\n');
  return token;
}

void callUsers() async {
  var url = Uri.parse('$cardsAPI/users');
  var token = createJWT();

  http.Response response = await http.get(
    Uri.parse('$cardsAPI/users'),
    // Send authorization headers to the backend.
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  print(response.statusCode);
  print(response.body);
}
