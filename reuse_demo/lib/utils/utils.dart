import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  //
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const THEME_INDEX_KEY = 'theme_index';
  static const LOGGED_IN = 'logged_in';

  static getTF(TextEditingController controller) {
    return TextField(
      controller: controller,
    );
  }

  static saveThemeIndex(int themeIndex) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(THEME_INDEX_KEY, themeIndex);
  }

  static getThemeIndex() async {
    final SharedPreferences prefs = await _prefs;
    int themeIndex = prefs.getInt(THEME_INDEX_KEY)?? 0;
    if (null == themeIndex) {
      themeIndex = 0;
    }
    return themeIndex;
  }

  static saveLoggedIn(bool loggedIn) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(LOGGED_IN, loggedIn);
  }

  static isLoggedIn() async {
    final SharedPreferences prefs = await _prefs;
    bool isLoggedIn = prefs.getBool(LOGGED_IN) ?? false;
    return null != isLoggedIn && isLoggedIn;
  }
}
