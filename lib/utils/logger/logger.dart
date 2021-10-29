import 'package:http/http.dart';
import 'package:prototype2021/settings/constants.dart';
import 'dart:convert';

// Feel free to add more groups :)
const Map<String, bool> _loggerConfig = {
  "1": true, // Important things
  "2": false, // Not important things
  "http": false,
};

class Logger {
  static void logHTTP(Response res, {bool fromBytes = false}) {
    if (DEBUG && _loggerConfig["http"]!) {
      if (fromBytes) {
        print("[ Response Body ] : ${utf8.decode(res.bodyBytes)}");
      } else {
        print("[ Response Body ] : ${res.body.toString()}");
      }
      print("[ Status Code ] : ${res.statusCode.toString()}");
    }
  }

  static void log(dynamic body) {
    if (DEBUG) {
      print(body);
    }
  }

  static void errorWithInfo(dynamic body, String info) {
    log("Error on $info:");
    log(body);
  }

  /// Use this group for important things
  static void group1(dynamic body) {
    if (_loggerConfig["1"]!) {
      log(body);
    }
  }

  /// Use this group for not important things
  static void group2(dynamic body) {
    if (_loggerConfig["2"]!) {
      log(body);
    }
  }
}
