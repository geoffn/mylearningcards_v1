import 'package:mylearningcards_v1/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesFunction {
  void setCardName(String cardsetID, String cardsetName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cardsetID, cardsetName);
  }

  Future<String> getCardName(String cardsetID) async {
    final prefs = await SharedPreferences.getInstance();
    final cardsetName = await prefs.getString(cardsetID);

    return cardsetName ?? "";
  }

  void setCurrentCardset(String cardsetID, String cardsetName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kCurrenCardsetIDLabel, cardsetID);
    await prefs.setString(kCurrentCardsetNameLabel, cardsetName);
  }

  Future<Map<String, String>> getCurrentCardset() async {
    final prefs = await SharedPreferences.getInstance();
    final cardsetID = await prefs.getString(kCurrenCardsetIDLabel);
    final cardsetName = await prefs.getString(kCurrentCardsetNameLabel);

    print('$kCurrenCardsetIDLabel: $cardsetID');
    print('$kCurrentCardsetNameLabel: $cardsetName');

    return {
      kCurrenCardsetIDLabel: cardsetID ?? "",
      kCurrentCardsetNameLabel: cardsetName ?? ""
    };
  }
}
