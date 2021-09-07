import 'dart:convert';

import 'package:http/http.dart' show Response;
import 'package:http/http.dart' as http;
import 'package:prototype2021/model/safe_http_dto/base.dart';

Future<bool> legacyPOST(String url, Map? bodyMap) async {
  try {
    Response response = await http.post(Uri.parse(url),
        headers: defaultHeaders, body: jsonEncode(bodyMap));
    if (response.statusCode == 201) return true;
  } catch (e) {
    print('Unexpected Error occurred');
  }
  return false;
}

Future<bool> legacyPUT(String url, Map? bodyMap) async {
  try {
    Response response = await http.put(Uri.parse(url),
        headers: defaultHeaders, body: jsonEncode(bodyMap));
    print(response.body);
    if (response.statusCode == 200) return true;
  } catch (e) {
    print("Unexpected Error occurred");
  }
  return false;
}

Future<dynamic> legacyGET(String url) async {
  try {
    Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) return jsonDecode(response.body);
  } catch (e) {
    print("Unexpected Error occurred");
  }
  return null;
}
