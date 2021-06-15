import 'package:mylearningcards_v1/components/card_view_card.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/helpers/JWTGenerator.dart';
import 'package:mylearningcards_v1/helpers/shared_preferences_functions.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'dart:convert';

class CardsetFunctions {
  Future<List<dynamic>> generateCardView(String cardsetID) async {
    final uFunctions = UserFunctions();
    final loggedInUser = uFunctions.getCurrentUser();
    List allCards;

    String? newID = "";
    //print('LoggedIn: $loggedInUser');
    if (loggedInUser != null) {
      if (loggedInUser.providerData[0].uid != null) {
        newID = loggedInUser.providerData[0].uid != null
            ? loggedInUser.providerData[0].uid
            : '0';
      }
    }

    var token = JWTGenerator.createJWT(newID);

    //TODO: Add cardsetaccessed/:id
    try {
      http.Response response = await http.get(
        Uri.parse('$cardsAPI/cardsetaccessed/$cardsetID'),
        // Send authorization headers to the backend.
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
    try {
      http.Response response = await http.get(
        Uri.parse('$cardsAPI/cardset/$cardsetID'),
        // Send authorization headers to the backend.
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      //print(response.body);

      var cardDataResults = json.decode(response.body);
      print('CVS- $cardDataResults');
      var cardData = cardDataResults["results"][0];
      allCards = cardData["cards"];

      return allCards;
    } catch (e) {
      print(e);
    }
    allCards = [];
    return allCards;
  }

  Future<List<dynamic>> generateCardsetView(String? searchTerm) async {
    final UserFunctions uFunctions = UserFunctions();
    final SharedPreferencesFunction spFunctions = SharedPreferencesFunction();
    final loggedInUser = uFunctions.getCurrentUser();
    String searchParam = "/*";
    String searchURL = "";
    String? newID = "";
    //print('LoggedIn: $loggedInUser');
    if (loggedInUser != null) {
      if (loggedInUser.providerData[0].uid != null) {
        newID = loggedInUser.providerData[0].uid != null
            ? loggedInUser.providerData[0].uid
            : '0';
      }
    }

    var token = JWTGenerator.createJWT(newID);

    print('genereate $searchTerm');

    if (searchTerm != null && searchTerm != '') {
      print('genereate2 $searchTerm');
      searchParam = '/$searchTerm';
      searchURL = '$cardsAPI/cardsetsearch/$newID$searchParam';
    } else {
      searchURL = '$cardsAPI/cardsetforowner';
    }

    print('Search Term : $searchTerm');
    print('Search URL: $searchURL');
    http.Response response = await http.get(
      Uri.parse(searchURL),
      // Send authorization headers to the backend.
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    //print(response.statusCode);
    //print(response.body);

    var cardDataResults = json.decode(response.body);

    var cardData = cardDataResults["results"];

    //print('cardData: $cardData');

    for (var card in cardData) {
      spFunctions.setCardName(card["_id"], card["set_name"]);
      //print(card["set_name"]);
    }
    print('cFunction: $cardData');

    return cardData;
  }

  Future<List<dynamic>> generateAvailalbeCards(String? searchTerm) async {
    final uFunctions = UserFunctions();
    final loggedInUser = uFunctions.getCurrentUser();
    String searchParam = "/*";
    String searchURL = "";

    String? newID = "";
    //print('LoggedIn: $loggedInUser');
    if (loggedInUser != null) {
      if (loggedInUser.providerData[0].uid != null) {
        newID = loggedInUser.providerData[0].uid != null
            ? loggedInUser.providerData[0].uid
            : '0';
      }
    }

    var token = JWTGenerator.createJWT(newID);

    if (searchTerm != null && searchTerm != '') {
      searchParam = '/$searchTerm';
      searchURL = '$cardsAPI/cardsearch/$newID$searchParam';
    } else {
      searchURL = '$cardsAPI/card/$newID';
    }

    print('Search Term : $searchTerm');
    print('Search URL: $searchURL');
    http.Response response = await http.get(
      Uri.parse(searchURL),
      // Send authorization headers to the backend.
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
    //print(response.body);

    var cardDataResults = json.decode(response.body);
    print('CVS- $cardDataResults');
    var cardData = cardDataResults["results"];
    print(cardData);

    return cardData;
  }

  Future<String> generateCardsetDetails(String cardsetID) async {
    final uFunctions = UserFunctions();
    final loggedInUser = uFunctions.getCurrentUser();

    String? newID = "";
    //print('LoggedIn: $loggedInUser');
    if (loggedInUser != null) {
      if (loggedInUser.providerData[0].uid != null) {
        newID = loggedInUser.providerData[0].uid != null
            ? loggedInUser.providerData[0].uid
            : '0';
      }
    }
    var token = JWTGenerator.createJWT(newID);

    http.Response response = await http.get(
      Uri.parse('$cardsAPI/cardset/$cardsetID'),
      // Send authorization headers to the backend.
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print(response.statusCode);
    //print(response.body);

    var cardDataResults = json.decode(response.body);
    print('CVS- $cardDataResults');
    var cardData = cardDataResults["results"][0];
    return cardData["set_name"];
  }

  void removeCardFromCardsetFunction(String cardsetID, String cardID) async {
    final uFunctions = UserFunctions();
    final loggedInUser = uFunctions.getCurrentUser();

    String? newID = "";
    //print('LoggedIn: $loggedInUser');
    if (loggedInUser != null) {
      if (loggedInUser.providerData[0].uid != null) {
        newID = loggedInUser.providerData[0].uid != null
            ? loggedInUser.providerData[0].uid
            : '0';
      }
    }

    Map postData = {'cardId': cardID, 'cardSetId': cardsetID};
    var body = json.encode(postData);
    print(body);
    print(newID);
    var token = JWTGenerator.createJWT(newID);

    http.Response response = await http.post(
      Uri.parse('$cardsAPI/cardsetremovecard'),
      // Send authorization headers to the backend.
      headers: {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );
    print(response.statusCode);
    print(response.body);
  }

  void addCardToCardsetFunction(String cardsetID, String cardID) async {
    final uFunctions = UserFunctions();
    final loggedInUser = uFunctions.getCurrentUser();

    String? newID = "";
    //print('LoggedIn: $loggedInUser');
    if (loggedInUser != null) {
      if (loggedInUser.providerData[0].uid != null) {
        newID = loggedInUser.providerData[0].uid != null
            ? loggedInUser.providerData[0].uid
            : '0';
      }
    }

    Map postData = {'cardId': cardID, 'cardSetId': cardsetID};
    var body = json.encode(postData);
    print(body);
    print(newID);
    var token = JWTGenerator.createJWT(newID);

    http.Response response = await http.post(
      Uri.parse('$cardsAPI/cardsetaddcard'),
      // Send authorization headers to the backend.
      headers: {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: body,
    );
    print(response.statusCode);
    print(response.body);
  }
}
