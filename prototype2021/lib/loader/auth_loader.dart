import 'dart:io';

import 'package:prototype2021/data/dto/safe_http/base.dart';
import 'package:prototype2021/data/dto/safe_http/get/wishlist.dart';
import 'package:prototype2021/data/dto/safe_http/post/login.dart';
import 'package:prototype2021/loader/safe_http.dart';
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

  Future<bool> validateToken(String? token) async {
    if (token == null) return false;
    ContentsWishlistInput params = new ContentsWishlistInput();
    SafeQueryInput<ContentsWishlistInput> dto =
        new SafeQueryInput(url: validateTokenUrl, params: params, token: token);
    SafeQueryOutput<ContentsWishlistOutput> result =
        await safeGET<ContentsWishlistInput, ContentsWishlistOutput>(dto);
    if (result.success) return true;
    return false;
  }

  // Fetching Functions

  Future<SafeMutationOutput<LoginOutput>> login(
          SafeMutationInput<LoginInput> dto) async =>
      await safePOST<LoginInput, LoginOutput>(dto, 200);

  // Endpoints

  String loginUrl = "$apiBaseUrl/user/login";
  String validateTokenUrl = "$apiBaseUrl/contents/wishlists";
}
