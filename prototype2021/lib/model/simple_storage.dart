import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Exception noSuchValueException(String key) => Exception('No such value: $key');

/*
 * SimpleStorage를 사용해야 할 상황이 생기면 
 * 여기에 키를 생성하고 생성한 키를 이용해 읽기/쓰기를 해주시기 바랍니다
 * 이는 여러 사람들이 SimpleStorage를 쓸 때 key의 중복을 방지하기 위함입니다
*/
class SimpleStorageKeys {
  // [List<String>] 최근 검색목록의 리스트를 저장합니다
  static String recentSearch = 'recentSearch';

  // [String] 백엔드 인증에 쓰이는 JWT TOKEN을 저장합니다
  static String jwtToken = "token";

  // [bool] 사용자가 자동로그인을 선택하였는지 그 여부를 저장합니다
  static String autoLogin = "autoLogin";

  // [bool] 사용자가 아이디저장을 선택하였는지 그 여부를 저장합니다
  static String doSaveId = "doSaveId";

  // [String] 사용자가 아이디 저장을 선택했을때 불러올 아이디 입니다
  static String savedId = "savedId";

  // [int] 사용자의 userId 입니다
  static String userId = "userId";
}

class SimpleStorage {
  static Future<String?> readString(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (error) {
      return null;
    }
  }

  static Future<int?> readInt(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getInt(key);
    } catch (error) {
      return null;
    }
  }

  static Future<double?> readDouble(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(key);
    } catch (error) {
      return null;
    }
  }

  static Future<bool?> readBool(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(key);
    } catch (error) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> readMap(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString(key) == null) throw noSuchValueException(key);
      return jsonDecode(prefs.getString(key)!) as Map<String, dynamic>?;
    } catch (error) {
      return null;
    }
  }

  static Future<List<dynamic>?> readList(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString(key) == null) throw noSuchValueException(key);
      return jsonDecode(prefs.getString(key)!);
    } catch (error) {
      return null;
    }
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
