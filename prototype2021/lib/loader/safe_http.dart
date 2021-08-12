import 'dart:convert';

import 'package:http/http.dart' as http;

Future<bool> safePOST(String url, Map? bodyMap) async {
  try {
    var response = await http.post(Uri.parse(url),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "X-CSRFToken":
              "ZrWI7Mf1KMz2WYJjQqo3H30l25UdY4bPcP3RthSlRMoUj7hGxz5Vp6fBWKS0n235"
        },
        body: jsonEncode(bodyMap));
    print(response.body);
    if (response.statusCode == 201) return true;
  } catch (e) {
    print("Unexpected Error occurred");
  }
  return false;
}

Future<bool> safePUT(String url, Map? bodyMap) async {
  try {
    var response = await http.put(Uri.parse(url),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "X-CSRFToken":
              "ZrWI7Mf1KMz2WYJjQqo3H30l25UdY4bPcP3RthSlRMoUj7hGxz5Vp6fBWKS0n235"
        },
        body: jsonEncode(bodyMap));
    print(response.body);
    if (response.statusCode == 200) return true;
  } catch (e) {
    print("Unexpected Error occurred");
  }
  return false;
}

Future<dynamic> safeGET(String url) async {
  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) return jsonDecode(response.body);
  } catch (e) {
    print("Unexpected Error occurred");
  }
  return null;
}
