import 'package:shared_preferences/shared_preferences.dart';

class Storage {
// Obtain shared preferences.
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setToken(String token) async {
    await prefs.setString('token', token);
  }

  static getToken() {
    return prefs.getString('token');
  }

  static Future<void> setRole(String role) async {
    await prefs.setString('role', role);
  }

  static getRole() {
    return prefs.getString('role');
  }

  static Future<void> removeAll() async {
    await prefs.clear();
  }
}
