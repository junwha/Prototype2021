import 'package:flutter_test/flutter_test.dart';
import 'package:prototype2021/loader/contents_loader.dart';
import 'package:prototype2021/loader/signin_loader.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';
import 'package:prototype2021/model/safe_http_dto/get/contents.dart';
import 'package:prototype2021/model/safe_http_dto/post/login.dart';

void main() {
  setUp(() async {
    await login();
  });

  group('[Class] ContentsLoader', testContentsLoader);
}

class _Credentials {
  static String username = "test2";
  static String password = "1234";
}

String token = "";

Future<void> login() async {
  SigninLoader signinLoader = new SigninLoader();
  LoginInput data = new LoginInput(
      username: _Credentials.username, password: _Credentials.password);
  SafeMutationInput<LoginInput> dto =
      new SafeMutationInput<LoginInput>(data: data, url: signinLoader.loginUrl);
  SafeMutationOutput<LoginOutput> result = await signinLoader.login(dto);
  token = result.data!.token;
}

void testContentsLoader() {
  group('[Fetching Method] contentsHeart', testContentsHeart);
  group('[Fetching Method] contentsList', testContentsList);
}

void testContentsHeart() {}

void testContentsList() {
  ContentsLoader contentsLoader = new ContentsLoader();
  test('should get the response', () async {
    ContentsListInput params = new ContentsListInput();
    SafeQueryInput<ContentsListInput> dto = new SafeQueryInput(
        url: contentsLoader.contentsListUrl, params: params, token: token);
    SafeQueryOutput<ContentsListOutput> result =
        await contentsLoader.contentsList(dto);
    expect(result.data?.results != null, true);
  });
}
