import 'dart:convert';

import 'package:http/http.dart' show Response;
import 'package:http/http.dart' as http;
import 'package:prototype2021/utils/logger/logger.dart';
import 'package:prototype2021/utils/safe_http/base.dart';

Future<bool> legacyPOST(String url, Map? bodyMap,
    {Map<String, String>? headers}) async {
  try {
    Response response = await http.post(Uri.parse(url),
        headers: headers ?? defaultHeaders, body: jsonEncode(bodyMap));
    if (response.statusCode == 201) return true;
  } catch (e) {
    Logger.errorWithInfo('Unexpected Error occurred', "legacy_http.dart");
  }
  return false;
}

Future<bool> legacyPUT(String url, Map? bodyMap,
    {Map<String, String>? headers}) async {
  try {
    Response response = await http.put(Uri.parse(url),
        headers: headers ?? defaultHeaders, body: jsonEncode(bodyMap));
    if (response.statusCode == 200) return true;
  } catch (e) {
    Logger.errorWithInfo("Unexpected Error occurred", "legacy_http.dart");
  }
  return false;
}

Future<dynamic> legacyGET(String url) async {
  try {
    Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) return jsonDecode(response.body);
  } catch (e) {
    Logger.errorWithInfo("Unexpected Error occurred", "legacy_http.dart");
  }
  return null;
}
