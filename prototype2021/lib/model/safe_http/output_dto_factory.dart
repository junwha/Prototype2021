import 'dart:convert';

import 'package:prototype2021/model/safe_http/base.dart';
import 'package:prototype2021/model/safe_http/get/signup.dart';
import 'package:prototype2021/model/safe_http/get/verification.dart';
import 'package:prototype2021/model/safe_http/post/authentication.dart';
import 'package:prototype2021/model/safe_http/post/login.dart';

final factories = <Type, SafeHttpDataOutput Function(Map<String, dynamic>)>{
  AuthOutput: (Map<String, dynamic> json) => AuthOutput.fromJson(json: json),
  AuthVerificationOutput: (Map<String, dynamic> json) =>
      AuthVerificationOutput.fromJson(json: json),
  IdVerificationOutput: (Map<String, dynamic> json) =>
      IdVerificationOutput.fromJson(json: json),
  SignupOutput: (Map<String, dynamic> json) =>
      SignupOutput.fromJson(json: json),
  LoginOutput: (Map<String, dynamic> json) => LoginOutput.fromJson(json: json),
};

T generateOutput<T extends SafeHttpDataOutput>(String jsonString) {
  return factories[T]!(jsonDecode(jsonString)) as T;
}
