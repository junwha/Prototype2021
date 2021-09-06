import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;
import 'package:prototype2021/model/safe_http/base.dart';

Future<SafeMutationOutput<O>>
    safePOST<I extends SafeHttpDataInput, O extends SafeHttpDataOutput>(
        SafeMutationInput<I> dto,
        [int expectedCode = 201]) async {
  try {
    Response res = await http.post(dto.getUrl(),
        headers: dto.getHeaders(), body: dto.getJsonString());
    if (res.statusCode == expectedCode)
      return new SafeMutationOutput<O>(success: true, data: res.body);
    throw new HttpException("[${res.statusCode}] : ${res.body.toString()}");
  } catch (error) {
    return new SafeMutationOutput<O>(
        success: false, error: new SafeHttpError(message: error.toString()));
  }
}

Future<SafeMutationOutput<O>>
    safePUT<I extends SafeHttpDataInput, O extends SafeHttpDataOutput>(
        SafeMutationInput<I> dto,
        [int expectedCode = 200]) async {
  try {
    Response res = await http.put(dto.getUrl(),
        headers: dto.getHeaders(), body: dto.getJsonString());
    if (res.statusCode == expectedCode)
      return new SafeMutationOutput<O>(success: true, data: res.body);
    throw new HttpException("[${res.statusCode}] : ${res.body.toString()}");
  } catch (error) {
    return new SafeMutationOutput<O>(
        success: false, error: new SafeHttpError(message: error.toString()));
  }
}

Future<SafeQueryOutput<O>>
    safeGET<I extends SafeHttpDataInput, O extends SafeHttpDataOutput>(
        SafeQueryInput<I> dto,
        [int expectedCode = 200]) async {
  try {
    Response res =
        await http.get(dto.getUrlWithQueryStrings(), headers: dto.getHeaders());
    if (res.statusCode == expectedCode)
      return new SafeQueryOutput<O>(success: true, data: res.body);
    throw new HttpException("[${res.statusCode} : ${res.body.toString()}]");
  } catch (error) {
    return new SafeQueryOutput<O>(
        success: false, error: new SafeHttpError(message: error.toString()));
  }
}
