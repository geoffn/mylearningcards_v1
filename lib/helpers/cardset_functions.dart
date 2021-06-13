import 'package:mylearningcards_v1/components/card_view.dart';
import 'package:mylearningcards_v1/conf/conf_dev.dart';
import 'package:http/http.dart' as http;
import 'package:mylearningcards_v1/components/jwt.dart';
import 'package:mylearningcards_v1/helpers/user_functions.dart';
import 'dart:convert';

class CardsetFunctions {
  Future<List<CardViewCard>> generateCardView(String cardsetID) async {
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
    var allCards = cardData["cards"];

    List<CardViewCard> cardsets = [];

    for (var card in allCards) {
      CardViewCard cardset = CardViewCard(
        cardID: card["_id"],
        cardPrimary: card["primary_word"],
        cardSecondary: card["secondary_word"],
        cardCategory: card["category"],
      );
      print("In For Loop");
      cardsets.add(cardset);
      print(card["_id"]);
    }

    return cardsets;
  }

  Future<List<CardViewCard>> generateAvailalbeCards(String? searchTerm) async {
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
      searchParam = '/${searchTerm}';
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

    List<CardViewCard> cardsets = [];

    for (var card in cardData) {
      CardViewCard cardset = CardViewCard(
        cardID: card["_id"],
        cardPrimary: card["primary_word"],
        cardSecondary: card["secondary_word"],
        cardCategory: card["category"],
      );
      print("In For Loop");
      cardsets.add(cardset);
      print(card["_id"]);
    }

    return cardsets;
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
