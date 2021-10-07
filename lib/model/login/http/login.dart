import 'package:prototype2021/utils/safe_http/base.dart';

class LoginInput extends SafeHttpDataInput {
  final String username;
  final String password;

  LoginInput({required this.username, required this.password});

  @override
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}

class LoginOutput extends SafeHttpDataOutput {
  final String token;
  final int id;

  LoginOutput.fromJson({required Map<String, dynamic> json})
      : token = json['token'] as String,
        id = json['id'] as int;
}
