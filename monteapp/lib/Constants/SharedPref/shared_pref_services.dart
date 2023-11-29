

import 'dart:convert';

import 'package:monteapp/Models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String _keyUser = 'monteUser';

  static Future<void> saveUser(UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = userModel.toMap();
    await prefs.setString(_keyUser, jsonEncode(userJson));
  }

  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userModelJson = prefs.getString(_keyUser);
    if (userModelJson != null) {
      UserModel? userModel = UserModel.fromSharedPrefMap(jsonDecode(userModelJson));
      return userModel;
    }
    return null;
  }

  static Future<void> removeStudent() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }
}
