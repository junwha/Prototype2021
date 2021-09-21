import 'dart:io';

import 'package:prototype2021/loader/safe_http.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';
import 'package:prototype2021/model/safe_http_dto/post/login.dart';
import 'package:prototype2021/settings/constants.dart';

class AuthLoader {
  // Custom Functions

  Future<LoginOutput> requestToken(String username, String password) async {
    LoginInput data = new LoginInput(username: username, password: password);
    SafeMutationInput<LoginInput> dto =
        new SafeMutationInput(data: data, url: loginUrl);
    SafeMutationOutput<LoginOutput> result = await login(dto);
    if (result.success && result.data != null) return result.data!;
    throw HttpException(result.error?.message ?? "Unexpected error");
  }

  // Fetching Functions

  Future<SafeMutationOutput<LoginOutput>> login(
          SafeMutationInput<LoginInput> dto) async =>
      await safePOST<LoginInput, LoginOutput>(dto);

  // Endpoints

  String loginUrl = "$apiBaseUrl/user/login";
}
