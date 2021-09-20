import 'dart:convert';

import 'package:prototype2021/model/safe_http_dto/output_dto_factory.dart';

const Map<String, String> defaultHeaders = {
  "accept": "application/json",
  "Content-Type": "application/json",
  "X-CSRFToken":
      "ZrWI7Mf1KMz2WYJjQqo3H30l25UdY4bPcP3RthSlRMoUj7hGxz5Vp6fBWKS0n235"
};

/*
 * Use the method below as a dto for params at get, options, delete, etc...
 * and for fetchnig data at post, put, patch, etc...
 */
abstract class SafeHttpDataInput {
  Map<String, dynamic>? toJson();
  Map<String, String>? getUrlParams();
}

class SafeHttpDataOutput {
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
  final String? token;

  /*
   * 만약 토큰이 주어지면 헤더에 토큰을 넣습니다
  */

  SafeHttpInput({required this.url, headers, this.token})
      : headers = headers ?? defaultHeaders;

  /*
   * This method does not mutates header
   */
  Map<String, String>? getHeaders() {
    if (token == null || headers?['Authorization'] != null) {
      return headers;
    }
    Map<String, String> copyOfHeaders = headers!;
    copyOfHeaders['Authorization'] = 'jwt $token';
    return copyOfHeaders;
  }

  Uri getUrl() => Uri.parse(url);
}

class SafeHttpOutput<T extends SafeHttpDataOutput> {
  final bool success;
  final T? data;
  final SafeHttpError? error;

  SafeHttpOutput({required this.success, this.error, String? rawData})
      : data = rawData == null ? null : generateOutput<T>(rawData);
}

/* 
 * post, put, patch 등 
 * post 메소드와 같은 방법으로 데이터를 실어 보내는 http method에 쓰이는 인풋 클래스입니다
 * 이를 직접적으로 쓸 경우는 드물 것이고, 제너릭 타입으로 들어가는 T에 들어갈
 * 클래스를 만들어서 이 클래스와 같이 쓰는 방식입니다
*/
class SafeMutationInput<T extends SafeHttpDataInput> extends SafeHttpInput {
  final T data;

  SafeMutationInput(
      {required this.data,
      required String url,
      Map<String, String>? headers,
      String? token})
      : super(headers: headers, url: url, token: token);

  String getJsonString() => jsonEncode(data.toJson());

  Uri getUrlWithParams() {
    String urlWithUrlParams = url;
    if (data.getUrlParams() != null) {
      data.getUrlParams()!.entries.forEach((element) {
        urlWithUrlParams =
            urlWithUrlParams.replaceAll(RegExp(element.key), element.value);
      });
    }
    return Uri.parse(urlWithUrlParams);
  }
}

/* 
 * post, put, patch 등 
 * post 메소드와 같은 방법으로 데이터를 실어 보내는 http method에 쓰이는 아웃풋 클래스입니다
 * 이를 직접적으로 쓸 경우는 드물 것이고, 제너릭 타입으로 들어가는 T에 들어갈
 * 클래스를 만들어서 이 클래스와 같이 쓰는 방식입니다
*/
class SafeMutationOutput<T extends SafeHttpDataOutput>
    extends SafeHttpOutput<T> {
  SafeMutationOutput(
      {required bool success, String? data, SafeHttpError? error})
      : super(success: success, error: error, rawData: data);
}

/* 
 * get, option, delete 등 
 * get과 같은 방식으로 데이터를 실어보내는 http method에 쓰이는 인풋 클래스입니다
 * 이를 직접적으로 쓸 경우는 드물 것이고, 제너릭 타입으로 들어가는 T에 들어갈
 * 클래스를 만들어서 이 클래스와 같이 쓰는 방식입니다
*/
class SafeQueryInput<T extends SafeHttpDataInput> extends SafeHttpInput {
  final T? params;

  SafeQueryInput(
      {required String url,
      Map<String, String>? headers,
      this.params,
      String? token})
      : super(url: url, headers: headers, token: token);

  Uri getUrlWithParams() {
    String queryString = "";
    if (params?.toJson() != null) {
      queryString += "?";
      params!.toJson()!.forEach((key, value) {
        queryString += "$key=$value&";
      });
      queryString = queryString.substring(0, queryString.length - 1);
    }
    String urlWithUrlParams = url;
    if (params?.getUrlParams() != null) {
      params!.getUrlParams()!.entries.forEach((element) {
        urlWithUrlParams =
            urlWithUrlParams.replaceAll(RegExp(element.key), element.value);
      });
    }
    return Uri.parse("$urlWithUrlParams$queryString");
  }
}

/* 
 * get, option, delete 등 
 * get과 같은 방식으로 데이터를 실어보내는 http method에 쓰이는 인풋 클래스입니다
 * 이를 직접적으로 쓸 경우는 드물 것이고, 제너릭 타입으로 들어가는 T에 들어갈
 * 클래스를 만들어서 이 클래스와 같이 쓰는 방식입니다
*/
class SafeQueryOutput<T extends SafeHttpDataOutput> extends SafeHttpOutput<T> {
  SafeQueryOutput({required bool success, String? data, SafeHttpError? error})
      : super(success: success, error: error, rawData: data);
}
