import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;
import 'package:prototype2021/model/safe_http_dto/base.dart';
import 'package:prototype2021/settings/constants.dart';

/* 
 * 함수를 부를때 타입 I, O는 필수로 넣어주셔야 합니다.
 * 타입이 주어지지 않으면 return 값이 제대로 나오지 않습니다
*/
Future<SafeMutationOutput<O>>
    safePOST<I extends SafeHttpDataInput, O extends SafeHttpDataOutput>(
  SafeMutationInput<I> dto, [
  int expectedCode = 201,
  bool fromBytes = false,
]) async {
  try {
    Response res = await http.post(dto.getUrlWithParams(),
        headers: dto.getHeaders(), body: dto.getJsonString());
    if (SAFE_HTTP_DEBUG) print(res.body);
    if (res.statusCode == expectedCode) {
      String data = fromBytes ? utf8.decode(res.bodyBytes) : res.body;
      return new SafeMutationOutput<O>(success: true, data: data);
    }
    throw new HttpException("[${res.statusCode}] : ${res.body.toString()}");
  } catch (error) {
    return new SafeMutationOutput<O>(
        success: false, error: new SafeHttpError(message: error.toString()));
  }
}

/* 
 * 함수를 부를때 타입 I, O는 필수로 넣어주셔야 합니다.
 * 타입이 주어지지 않으면 return 값이 제대로 나오지 않습니다
*/
Future<SafeMutationOutput<O>>
    safePUT<I extends SafeHttpDataInput, O extends SafeHttpDataOutput>(
  SafeMutationInput<I> dto, [
  int expectedCode = 200,
  bool fromBytes = false,
]) async {
  try {
    Response res = await http.put(dto.getUrlWithParams(),
        headers: dto.getHeaders(), body: dto.getJsonString());
    if (SAFE_HTTP_DEBUG) print(res.body);
    if (res.statusCode == expectedCode) {
      String data = fromBytes ? utf8.decode(res.bodyBytes) : res.body;
      return new SafeMutationOutput<O>(success: true, data: data);
    }
    throw new HttpException("[${res.statusCode}] : ${res.body.toString()}");
  } catch (error) {
    return new SafeMutationOutput<O>(
        success: false, error: new SafeHttpError(message: error.toString()));
  }
}

/* 
 * 함수를 부를때 타입 I, O는 필수로 넣어주셔야 합니다.
 * 타입이 주어지지 않으면 return 값이 제대로 나오지 않습니다
*/
Future<SafeMutationOutput<O>>
    safePatch<I extends SafeHttpDataInput, O extends SafeHttpDataOutput>(
  SafeMutationInput<I> dto, [
  int expectedCode = 201,
  bool fromBytes = false,
]) async {
  try {
    Response res = await http.patch(dto.getUrlWithParams(),
        headers: dto.getHeaders(), body: dto.getJsonString());
    if (SAFE_HTTP_DEBUG) print(res.body);
    if (res.statusCode == expectedCode) {
      String data = fromBytes ? utf8.decode(res.bodyBytes) : res.body;
      return new SafeMutationOutput<O>(success: true, data: data);
    }
    throw new HttpException("[${res.statusCode}] : ${res.body.toString()}");
  } catch (error) {
    return new SafeMutationOutput<O>(
        success: false, error: new SafeHttpError(message: error.toString()));
  }
}

/* 
 * 함수를 부를때 타입 I, O는 필수로 넣어주셔야 합니다.
 * 타입이 주어지지 않으면 return 값이 제대로 나오지 않습니다
*/
Future<SafeQueryOutput<O>>
    safeGET<I extends SafeHttpDataInput, O extends SafeHttpDataOutput>(
  SafeQueryInput<I> dto, [
  int expectedCode = 200,
  bool fromBytes = false,
]) async {
  try {
    Response res =
        await http.get(dto.getUrlWithParams(), headers: dto.getHeaders());
    if (SAFE_HTTP_DEBUG) print(res.body);
    if (res.statusCode == expectedCode) {
      String data = fromBytes ? utf8.decode(res.bodyBytes) : res.body;
      return new SafeQueryOutput<O>(success: true, data: data);
    }
    throw new HttpException("[${res.statusCode} : ${res.body.toString()}]");
  } catch (error) {
    return new SafeQueryOutput<O>(
        success: false, error: new SafeHttpError(message: error.toString()));
  }
}
