import 'package:prototype2021/loader/login/login_loader.dart';
import 'package:prototype2021/model/login/http/login.dart';
import 'package:prototype2021/utils/safe_http/base.dart';

class _Credentials {
  static String username = "test2";
  static String password = "1234";
}

Future<String> login() async {
  LoginLoader loginLoader = new LoginLoader();
  LoginInput data = new LoginInput(
      username: _Credentials.username, password: _Credentials.password);
  SafeMutationInput<LoginInput> dto =
      new SafeMutationInput<LoginInput>(data: data, url: loginLoader.loginUrl);
  SafeMutationOutput<LoginOutput> result = await loginLoader.login(dto);
  return result.data!.token;
}
