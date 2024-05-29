import 'package:shared_preferences/shared_preferences.dart';

class MyLogin {
  static void isLoggedIn(bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("LoggedIn", value);
  }

  static Future<bool> getLoggedInValue() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool value = sp.getBool("LoggedIn") ?? false;
    return value;
  }
}
