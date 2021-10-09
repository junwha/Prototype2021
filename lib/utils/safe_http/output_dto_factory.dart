import 'dart:convert';

import 'package:prototype2021/utils/safe_http/base.dart';
import 'package:prototype2021/model/board/contents/http/contents.dart';
import 'package:prototype2021/model/board/plan/http/plan.dart';
import 'package:prototype2021/model/signin/http/verification.dart';
import 'package:prototype2021/model/board/wishlist/http/heart.dart';
import 'package:prototype2021/model/signin/http/authentication.dart';
import 'package:prototype2021/model/login/http/login.dart';
import 'package:prototype2021/model/signin/http/signup.dart';

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
  PlanListOutput: (json) => PlanListOutput.fromJson(json: json),
  PlanDetailOutput: (json) => PlanDetailOutput.fromJson(json: json),
  PlanCreateOutput: (json) => PlanCreateOutput.fromJson(json: json),
  // This key-value pair is for test purpose
  ExampleOutput: (json) => ExampleOutput.fromJson(json: json),
};

class FactoryNotDefined<T> implements Exception {
  final dynamic message = T.toString() +
      " isn't defined in the output dto factory (output_dto_factory.dart)";

  FactoryNotDefined();
}

T generateOutput<T extends SafeHttpDataOutput>(String jsonString) {
  if (!_factories.containsKey(T)) throw FactoryNotDefined<T>();
  return _factories[T]!(jsonDecode(jsonString)) as T;
}

// This class is for test purpose
class ExampleOutput extends SafeHttpDataOutput {
  final String prop;

  ExampleOutput.fromJson({required Map<String, dynamic> json})
      : prop = json['prop'] as String;
}
