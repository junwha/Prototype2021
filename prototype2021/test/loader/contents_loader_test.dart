import 'package:flutter_test/flutter_test.dart';
import 'package:prototype2021/loader/contents_loader.dart';
import 'package:prototype2021/loader/signin_loader.dart';
import 'package:prototype2021/model/contents_dto/content_preview.dart';
import 'package:prototype2021/model/safe_http_dto/base.dart';
import 'package:prototype2021/model/safe_http_dto/get/contents.dart';
import 'package:prototype2021/model/safe_http_dto/post/login.dart';

class _Credentials {
  static String username = "test2";
  static String password = "1234";
}

void main() {
  setUpAll(() async {
    await login();
  });

  group('[Class] ContentsLoader', testContentsLoader);
}

String token = "";
List<ContentPreview>? sampleData;
ContentsLoader? contentsLoader;

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
  contentsLoader = new ContentsLoader();
  group('[Fetching Method] contentsList', testContentsList);
  group('[Fetching Method] contentsHeart', testContentsHeart);
  group('[Fetching Method] contentsWishlist', testContentsWishlist);
  group('[Fetching Method] contentsDetail', testContentsDetail);
}

void testContentsList() {
  test('should get the response', () async {
    ContentsListInput params = new ContentsListInput();
    SafeQueryInput<ContentsListInput> dto = new SafeQueryInput(
        url: contentsLoader!.contentsListUrl, params: params, token: token);
    SafeQueryOutput<ContentsListOutput> result =
        await contentsLoader!.contentsList(dto);
    expect(result.data?.results != null, true);
    expect(result.data!.results is List<ContentPreview>, true);
    expect(result.data!.count > 0, true);
    expect(result.data!.previous, null);
    sampleData = result.data!.results;
  });
}

void testContentsHeart() {
  test('should heart the content', () async {
    bool success = true;
    try {
      await contentsLoader!.heartContents(sampleData![0].id.toString(), token);
    } catch (error) {
      success = false;
    }
    expect(success, true);
  });
}

void testContentsWishlist() {
  test('should get wishlist', () async {
    ContentsWishlistInput params = new ContentsWishlistInput();
    SafeQueryInput<ContentsWishlistInput> dto = new SafeQueryInput(
        url: contentsLoader!.contentsWishlistUrl, params: params, token: token);
    SafeQueryOutput<ContentsWishlistOutput> result =
        await contentsLoader!.contentsWishlist(dto);
    expect(result.data?.results != null, true);
    expect(result.data!.results is List<ContentPreview>, true);
  });
}

void testContentsDetail() {
  test('should get detail', () async {
    await Future.forEach<ContentPreview>(sampleData!, (datum) async {
      ContentsDetailInput params = new ContentsDetailInput(id: datum.id);
      SafeQueryInput<ContentsDetailInput> dto = new SafeQueryInput(
          url: contentsLoader!.contentsDetailUrl, params: params, token: token);
      SafeQueryOutput<ContentsDetailOutput> result =
          await contentsLoader!.contentsDetail(dto);
      print(result.error?.message);
      expect(result.data?.result != null, true);
    });
  });
}
