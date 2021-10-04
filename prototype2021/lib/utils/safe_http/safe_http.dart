import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart'
    show Response, MultipartFile, MultipartRequest, StreamedResponse;
import 'package:image_picker/image_picker.dart';
import 'package:prototype2021/utils/safe_http/base.dart';
import 'package:prototype2021/settings/constants.dart';

void printHTTPLog(http.Response res, {bool fromBytes = false}) {
  if (SAFE_HTTP_DEBUG) {
    if (fromBytes) {
      print("[ Response Body ] : ${utf8.decode(res.bodyBytes)}");
    } else {
      print("[ Response Body ] : ${res.body.toString()}");
    }
    print("[ Status Code ] : ${res.statusCode.toString()}");
  }
}

HttpException generateHttpException(Response res) {
  return new HttpException("[${res.statusCode}] : ${res.body.toString()}");
}

Future<List<MultipartFile>> filesToAttach(Map<String, dynamic> filesMap) async {
  List<MultipartFile> files = [];
  for (var fileEntry in filesMap.entries) {
    if (fileEntry.value is XFile) {
      XFile file = fileEntry.value;
      int fileLength = await file.length();
      files.add(MultipartFile(
          fileEntry.key, file.readAsBytes().asStream(), fileLength));
    }
    if (fileEntry.value is File) {
      File file = fileEntry.value;
      files.add(MultipartFile(
          fileEntry.key, file.readAsBytes().asStream(), file.lengthSync()));
    }
  }
  return files;
}

Future<SafeMutationOutput<O>> safeMultipartPost<I extends SafeHttpDataInput,
        O extends SafeHttpDataOutput>(SafeMutationInput<I> dto,
    [int expectedCode = 201]) async {
  try {
    MultipartRequest request = MultipartRequest('POST', dto.getUrlWithParams());
    if (dto.getJson() != null)
      request.fields.addAll(dto.getJson() as Map<String, String>);
    if (dto.getFiles() != null) {
      request.files.addAll(await filesToAttach(dto.getFiles()!));
    }
    StreamedResponse streamedResponse = await request.send();
    Response res = await Response.fromStream(streamedResponse);
    if (res.statusCode == expectedCode)
      return new SafeMutationOutput<O>(success: true, data: res.body);
    throw generateHttpException(res);
  } catch (error) {
    return new SafeMutationOutput(
        success: false, error: new SafeHttpError(message: error.toString()));
  }
}

Future<SafeMutationOutput<O>>
    safeMultipartPut<I extends SafeHttpDataInput, O extends SafeHttpDataOutput>(
        SafeMutationInput<I> dto,
        [int expectedCode = 200]) async {
  try {
    MultipartRequest request = MultipartRequest('POST', dto.getUrlWithParams());
    if (dto.getJson() != null)
      request.fields.addAll(dto.getJson() as Map<String, String>);
    if (dto.getFiles() != null) {
      request.files.addAll(await filesToAttach(dto.getFiles()!));
    }
    StreamedResponse streamedResponse = await request.send();
    Response res = await Response.fromStream(streamedResponse);
    if (res.statusCode == expectedCode)
      return new SafeMutationOutput<O>(success: true, data: res.body);
    throw generateHttpException(res);
  } catch (error) {
    return new SafeMutationOutput(
        success: false, error: new SafeHttpError(message: error.toString()));
  }
}

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
    printHTTPLog(res, fromBytes: fromBytes);

    if (res.statusCode == expectedCode) {
      String data = fromBytes ? utf8.decode(res.bodyBytes) : res.body;
      return new SafeMutationOutput<O>(success: true, data: data);
    }

    throw generateHttpException(res);
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

    printHTTPLog(res, fromBytes: fromBytes);
    if (res.statusCode == expectedCode) {
      String data = fromBytes ? utf8.decode(res.bodyBytes) : res.body;
      return new SafeMutationOutput<O>(success: true, data: data);
    }
    throw generateHttpException(res);
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
    printHTTPLog(res, fromBytes: fromBytes);

    if (res.statusCode == expectedCode) {
      String data = fromBytes ? utf8.decode(res.bodyBytes) : res.body;
      return new SafeMutationOutput<O>(success: true, data: data);
    }
    throw generateHttpException(res);
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
    print(dto.getUrlWithParams());
    Response res =
        await http.get(dto.getUrlWithParams(), headers: dto.getHeaders());
    printHTTPLog(res, fromBytes: fromBytes);

    if (res.statusCode == expectedCode) {
      String data = fromBytes ? utf8.decode(res.bodyBytes) : res.body;
      return new SafeQueryOutput<O>(success: true, data: data);
    }

    throw generateHttpException(res);
  } catch (error) {
    return new SafeQueryOutput<O>(
        success: false, error: new SafeHttpError(message: error.toString()));
  }
}

Future<SafeQueryOutput<O>>
    safeDELETE<I extends SafeHttpDataInput, O extends SafeHttpDataOutput>(
  SafeQueryInput<I> dto, [
  int expectedCode = 204,
  bool fromBytes = false,
]) async {
  try {
    Response res =
        await http.delete(dto.getUrlWithParams(), headers: dto.getHeaders());
    printHTTPLog(res, fromBytes: fromBytes);
    if (res.statusCode == expectedCode) {
      String data = fromBytes ? utf8.decode(res.bodyBytes) : res.body;
      return new SafeQueryOutput<O>(success: true, data: data);
    }
    if (res.statusCode == expectedCode)
      return new SafeQueryOutput<O>(success: true, data: res.body);
    throw generateHttpException(res);
  } catch (error) {
    return new SafeQueryOutput<O>(
        success: false, error: new SafeHttpError(message: error.toString()));
  }
}
