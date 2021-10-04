import 'package:flutter_test/flutter_test.dart';
import 'package:prototype2021/handler/login/login_handler.dart';
import 'package:prototype2021/utils/simple_storage/simple_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });
  group('[Class] LoginModel', testLoginModel);
}

void testLoginModel() {
  final bool autoLogin = true;
  final bool doSaveId = true;
  final String savedId = "blabibla";

  group('[Method] loadAutoLogin', () {
    test('should load autoLogin variable', () async {
      expect(await LoginHandler.loadAutoLogin(), false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(SimpleStorageKeys.autoLogin, autoLogin);
      expect(await LoginHandler.loadAutoLogin(), autoLogin);
    });
  });
  group('[Method] loadDoSaveId', () {
    test('should load doSaveId variable', () async {
      expect(await LoginHandler.loadDoSaveId(), false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(SimpleStorageKeys.doSaveId, doSaveId);
      expect(await LoginHandler.loadDoSaveId(), doSaveId);
    });
  });
  group('[Method] loadSavedId', () {
    test('should load savedId variable', () async {
      expect(await LoginHandler.loadSavedId(), null);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(SimpleStorageKeys.savedId, savedId);
      expect(await LoginHandler.loadSavedId(), savedId);
    });
  });

  group('[Method] writeAutoLogin', () {
    test('should write autoLogin variable', () async {
      bool success = false;
      try {
        await LoginHandler.writeAutoLogin(autoLogin);
        success = true;
      } catch (error) {
        print(error);
      }
      expect(success, true);
      expect(await LoginHandler.loadAutoLogin(), autoLogin);
    });
  });
  group('[Method] writeDoSaveId', () {
    test('should write doSaveId variable', () async {
      bool success = false;
      try {
        await LoginHandler.writeDoSaveId(doSaveId);
        success = true;
      } catch (error) {
        print(error);
      }
      expect(success, true);
      expect(await LoginHandler.loadDoSaveId(), doSaveId);
    });
  });
  group('[Method] writeSavedId', () {
    test('should write savedId variable', () async {
      bool success = false;
      try {
        await LoginHandler.writeSavedId(savedId);
        success = true;
      } catch (error) {
        print(error);
      }
      expect(success, true);
      expect(await LoginHandler.loadSavedId(), savedId);
    });
  });
}
