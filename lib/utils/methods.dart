
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thesurvey/main.dart';

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

bool doesNotContainSpaces(String input) {
  return !input.contains(' ');
}

int getMaxRId(List<Map<String, dynamic>> data) {
  return data.map((item) => item['rid'] as int).reduce((a, b) => a > b ? a : b);
}

int getMaxUId(List<Map<String, dynamic>> data) {
  return data.map((item) => item['uid'] as int).reduce((a, b) => a > b ? a : b);
}

// Check login status on app start
Future<bool> checkLoginStatus() async {
  bool isLoggedIn = false;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('isLoggedIn') != null) {
    isLoggedIn = prefs.getBool('isLoggedIn')!;
  }

  return isLoggedIn;
}

// Update login status
Future<void> updateLoginStatus(bool status) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(SplashPageState.KEY_LOGIN, status);
}

Future<void> updateLoginDetails(String uID, String uName, String uEmail) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(SplashPageState.KEY_LOGIN_DETAILS, [uID, uName, uEmail]);
}

// get login status
Future<List<String>?> getLoginDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? loginDetails = prefs.getStringList(SplashPageState.KEY_LOGIN_DETAILS);

  return loginDetails;
}

// Update login status
Future<void> clearSharedPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}
