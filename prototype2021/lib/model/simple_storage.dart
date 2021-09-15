import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Exception noSuchValueException(String key) => Exception('No such value: $key');

class SimpleStorage with ChangeNotifier {
  Future<String?> readString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<int?> readInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<double?> readDouble(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  Future<bool?> readBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<Map<String, dynamic>?> readMap(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) throw noSuchValueException(key);
    return jsonDecode(prefs.getString(key)!) as Map<String, dynamic>?;
  }

  Future<List<dynamic>?> readList(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) throw noSuchValueException(key);
    return jsonDecode(prefs.getString(key)!);
  }

  Future<void> writeString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    notifyListeners();
  }

  Future<void> writeInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
    notifyListeners();
  }

  Future<void> writeDouble(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
    notifyListeners();
  }

  Future<void> writeBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    notifyListeners();
  }

  Future<void> writeMap(String key, Map<String, dynamic> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
    notifyListeners();
  }

  Future<void> writeList(String key, List<dynamic> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
    notifyListeners();
  }
}
