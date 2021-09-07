import 'package:prototype2021/model/safe_http/base.dart';

class LoginInput implements SafeHttpDataInput {
  final String username;
  final String password;

  LoginInput({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}

class LoginOutput implements SafeHttpDataOutput {
  final String token;
  final int id;

  LoginOutput.fromJson({required Map<String, dynamic> json})
      : token = json['token'] as String,
        id = json['id'] as int;
}
