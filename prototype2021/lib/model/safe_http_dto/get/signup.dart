import 'dart:io';

import 'package:prototype2021/model/safe_http_dto/base.dart';

enum Gender { M, F, None }

class SignupInput extends SafeHttpDataInput {
  final String username;
  final String password;
  final File? photo;
  final Gender gender;
  final DateTime birth;
  final String? phoneNumber;
  final String? email;
  final String name;
  final bool agreeRequiredTerms;
  final bool agreeMarketingTerms;

  SignupInput({
    required this.username,
    required this.password,
    required this.gender,
    required this.birth,
    required this.name,
    required this.agreeMarketingTerms,
    required this.agreeRequiredTerms,
    this.photo,
    this.email,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "photo": photo,
        "gender": gender,
        "birth": birth,
        "phoneNumber": phoneNumber,
        "email": email,
        "name": name,
        "agreeRequiredTerms": agreeRequiredTerms,
        "agreeMarketingTerms": agreeMarketingTerms,
      };
}

class SignupOutput extends SafeHttpDataOutput {
  final int id;

  SignupOutput.fromJson({required Map<String, dynamic> json})
      : id = json['id'] as int;
}
