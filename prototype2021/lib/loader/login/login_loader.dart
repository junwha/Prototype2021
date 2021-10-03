import 'package:prototype2021/utils/safe_http/base.dart';
import 'package:prototype2021/model/login/http/login.dart';
import 'package:prototype2021/utils/safe_http/safe_http.dart';
import 'package:prototype2021/settings/constants.dart';

class LoginLoader {
  // Custom Functions

  // Fetching Functions

  Future<SafeMutationOutput<LoginOutput>> login(
          SafeMutationInput<LoginInput> dto) async =>
      await safePOST<LoginInput, LoginOutput>(dto, 200);

  // Endpoints

  String loginUrl = "$apiBaseUrl/user/login";
}
