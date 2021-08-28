import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;
import 'package:prototype2021/model/safe_http/base.dart';

Future<SafeMutationOutput<O>>
    safePOST<I extends SafeHttpDataInput, O extends SafeHttpDataOutput>(
        SafeMutationInput<I> dto) async {
  String error = "";
  try {
    Response response = await http.post(dto.getParsedUrl(),
        headers: dto.getHeaders(), body: dto.getJsonString());
    if (response.statusCode == 201)
      return new SafeMutationOutput(
          success: true, data: jsonDecode(response.body));
  } catch (e) {
    error = "Unexpected Error occurred: ${e.toString()}";
  }
  return new SafeMutationOutput(
      success: false, error: new SafeHttpError(message: error));
}

Future<bool> safePUT(String url, Map? bodyMap) async {
  try {
    Response response = await http.put(Uri.parse(url),
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
    Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) return jsonDecode(response.body);
  } catch (e) {
    print("Unexpected Error occurred");
  }
  return null;
}
