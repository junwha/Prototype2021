import 'dart:convert';

const Map<String, String> defaultHeaders = {
  "accept": "application/json",
  "Content-Type": "application/json",
  "X-CSRFToken":
      "ZrWI7Mf1KMz2WYJjQqo3H30l25UdY4bPcP3RthSlRMoUj7hGxz5Vp6fBWKS0n235"
};

enum SafeHttpVerb {
  GET,
  HEAD,
  POST,
  PUT,
  DELETE,
  CONNECT,
  OPTIONS,
  TRACE,
  PATCH
}

/*
 * Use the method below as a dto for params at get, options, delete, etc...
 * and for fetchnig data at post, put, patch, etc...
 */
abstract class SafeHttpDataInput {
  Map<String, dynamic> toJson();
}

abstract class SafeHttpDataOutput {
  /* 
   * Dart does not support constructor inheritance!! 
   * The code below is just for you to understand 
   * what this abstract class is for
   * for implementing this at the other places (hyeongyu)
  */
  SafeHttpDataOutput();
  SafeHttpDataOutput.fromJson({required Map<String, dynamic> json});
}

class SafeHttpError {
  final String message;

  SafeHttpError({required this.message});
}

class SafeHttpInput {
  final String url;
  final Map<String, String>? headers;
  final SafeHttpVerb httpMethod;
  final String? token;

  SafeHttpInput(
      {required this.url, required this.httpMethod, headers, this.token})
      : headers = headers ?? defaultHeaders;

  /*
   * This method does not mutates header
   */
  Map<String, String>? getHeaders() {
    if (token == null) {
      return headers;
    }
    Map<String, String> copyOfHeaders = headers!;
    copyOfHeaders['Authorization'] = 'Bearer $token';
    return copyOfHeaders;
  }

  Uri getParsedUrl() => Uri.parse(url);
}

class SafeHttpOutput<T extends SafeHttpDataOutput> {
  final bool success;
  final T? data;
  final SafeHttpError? error;

  SafeHttpOutput({required this.success, this.error, this.data});
}

// post, put, patch ...
class SafeMutationInput<T extends SafeHttpDataInput> extends SafeHttpInput {
  final T data;

  SafeMutationInput(
      {required this.data,
      required String url,
      required SafeHttpVerb httpMethod,
      Map<String, String>? headers})
      : super(headers: headers, url: url, httpMethod: httpMethod);

  String getJsonString() => jsonEncode(data.toJson());
}

class SafeMutationOutput<T extends SafeHttpDataOutput>
    extends SafeHttpOutput<T> {
  SafeMutationOutput({required bool success, T? data, SafeHttpError? error})
      : super(data: data, success: success, error: error);
}

// get, option, delete ...
class SafeQueryInput<T extends SafeHttpDataInput> extends SafeHttpInput {
  final T? params;

  SafeQueryInput(
      {required String url,
      required SafeHttpVerb httpMethod,
      Map<String, String>? headers,
      this.params})
      : super(url: url, headers: headers, httpMethod: httpMethod);

  String getUrlWithQueryStrings() {
    String queryString = "";
    if (params == null) return url;
    params!.toJson().forEach((key, value) {
      queryString += "$key=$value&";
    });
    queryString = queryString.substring(0, queryString.length - 1);
    return "$url?$queryString";
  }
}

class SafeQueryOutput<T extends SafeHttpDataOutput> extends SafeHttpOutput<T> {
  SafeQueryOutput({required bool success, T? data, SafeHttpError? error})
      : super(data: data, success: success, error: error);
}
