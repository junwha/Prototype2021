import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Exception noSuchValueException(String key) => Exception('No such value: $key');

class SimpleStorage {
  static Future<String?> readString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<int?> readInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<double?> readDouble(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  static Future<bool?> readBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<Map<String, dynamic>?> readMap(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) throw noSuchValueException(key);
    return jsonDecode(prefs.getString(key)!) as Map<String, dynamic>?;
  }

  static Future<List<dynamic>?> readList(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) throw noSuchValueException(key);
    return jsonDecode(prefs.getString(key)!);
  }

  static Future<void> writeString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<void> writeInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<void> writeDouble(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  static Future<void> writeBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<void> writeMap(String key, Map<String, dynamic> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
  }

  static Future<void> writeList(String key, List<dynamic> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
  }
}
