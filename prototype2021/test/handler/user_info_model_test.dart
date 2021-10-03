import 'package:flutter_test/flutter_test.dart';
import 'package:prototype2021/utils/simple_storage/simple_storage.dart';
import 'package:prototype2021/handler/user/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('[Class] UserInfoModel', testUserInfoModel);
}

void testUserInfoModel() {
  final String token = "someToken";
  final int userId = 0;

  group('[Method] loadToken', () {
    UserInfoModel model = new UserInfoModel();
    test('should loadToken', () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(SimpleStorageKeys.jwtToken, token);
      expect(model.token, null);
      await model.loadToken();
      expect(model.token, token);
    });
  });

  group('[Method] loadUserId', () {
    UserInfoModel model = new UserInfoModel();
    test('should loadUserId', () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt(SimpleStorageKeys.userId, userId);
      expect(model.userId, null);
      await model.loadUserId();
      expect(model.userId, userId);
    });
  });

  group('[Method] saveToken', () {
    SharedPreferences.setMockInitialValues({});
    UserInfoModel model = new UserInfoModel();
    test('should save token', () async {
      bool success = false;
      try {
        await model.saveToken(token);
        success = true;
      } catch (error) {
        print(error);
      }
      expect(success, true);
      await model.loadToken();
      expect(model.token, token);
    });
  });

  group('[Method] saveId', () {
    SharedPreferences.setMockInitialValues({});
    UserInfoModel model = new UserInfoModel();
    test('should save userId', () async {
      bool success = false;
      try {
        await model.saveId(userId);
        success = true;
      } catch (error) {
        print(error);
      }
      expect(success, true);
      await model.loadUserId();
      expect(model.userId, userId);
    });
  });
}
