import 'dart:convert';

import 'package:prototype2021/model/safe_http_dto/base.dart';
import 'package:prototype2021/model/safe_http_dto/get/contents.dart';
import 'package:prototype2021/model/safe_http_dto/patch/heart.dart';
import 'package:prototype2021/model/safe_http_dto/post/signup.dart';
import 'package:prototype2021/model/safe_http_dto/get/verification.dart';
import 'package:prototype2021/model/safe_http_dto/post/authentication.dart';
import 'package:prototype2021/model/safe_http_dto/post/login.dart';

final _factories = <Type, SafeHttpDataOutput Function(Map<String, dynamic>)>{
  AuthOutput: (json) => AuthOutput.fromJson(json: json),
  AuthVerificationOutput: (json) => AuthVerificationOutput.fromJson(json: json),
  IdVerificationOutput: (json) => IdVerificationOutput.fromJson(json: json),
  SignupOutput: (json) => SignupOutput.fromJson(json: json),
  LoginOutput: (json) => LoginOutput.fromJson(json: json),
  PlanHeartOutput: (_) => PlanHeartOutput.fromJson(),
  ContentsHeartOutput: (_) => ContentsHeartOutput.fromJson(),
  ContentsListOutput: (json) => ContentsListOutput.fromJson(json: json),
  ContentsWishlistOutput: (json) => ContentsWishlistOutput.fromJson(json: json),
  ContentsDetailOutput: (json) => ContentsDetailOutput.fromJson(json: json),
  // This key-value pair is for test purpose
  ExampleOutput: (json) => ExampleOutput.fromJson(json: json),
};

T generateOutput<T extends SafeHttpDataOutput>(String jsonString) {
  return _factories[T]!(jsonDecode(jsonString)) as T;
}

// This class is for test purpose
class ExampleOutput extends SafeHttpDataOutput {
  final String prop;

  ExampleOutput.fromJson({required Map<String, dynamic> json})
      : prop = json['prop'] as String;
}
