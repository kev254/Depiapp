import 'dart:convert';
import 'package:depi/models/property_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class SharedPreferencesService {
  static const String _userKey = 'user';
  static const String _postKey = 'post';


  static Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }
  static Future<void> savePost(Property property) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String propertyJson = jsonEncode(property.toJson());
    await prefs.setString(_postKey, propertyJson);
  }

  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(_userKey);
    if (userJson != null) {
      Map<String, dynamic> userData = jsonDecode(userJson);
      return User.fromJson(userData);
    }
    return null;
  }

  static Future<void> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
