import 'package:flutter_test/flutter_test.dart';
import 'package:prototype2021/model/login/login_model.dart';
import 'package:prototype2021/model/simple_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('[Class] LoginModel', testLoginModel);
}

void testLoginModel() {
  final bool autoLogin = true;
  final bool doSaveId = true;
  final String savedId = "blabibla";
  group('[Method] loadAutoLogin', () {
    test('should load autoLogin variable', () async {
      expect(await LoginModel.loadAutoLogin(), false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(SimpleStorageKeys.autoLogin, autoLogin);
      expect(await LoginModel.loadAutoLogin(), autoLogin);
    });
  });
  group('[Method] loadDoSaveId', () {
    test('should load doSaveId variable', () async {
      expect(await LoginModel.loadDoSaveId(), false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(SimpleStorageKeys.doSaveId, doSaveId);
      expect(await LoginModel.loadDoSaveId(), doSaveId);
    });
  });
  group('[Method] loadSavedId', () {
    test('should load savedId variable', () async {
      expect(await LoginModel.loadSavedId(), null);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(SimpleStorageKeys.savedId, savedId);
      expect(await LoginModel.loadSavedId(), savedId);
    });
  });

  group('[Method] writeAutoLogin', () {
    SharedPreferences.setMockInitialValues({});
    test('should write autoLogin variable', () async {
      bool success = false;
      try {
        await LoginModel.writeAutoLogin(autoLogin);
        success = true;
      } catch (error) {
        print(error);
      }
      expect(success, true);
      expect(await LoginModel.loadAutoLogin(), autoLogin);
    });
  });
  group('[Method] writeDoSaveId', () {
    SharedPreferences.setMockInitialValues({});
    test('should write doSaveId variable', () async {
      bool success = false;
      try {
        await LoginModel.writeDoSaveId(doSaveId);
        success = true;
      } catch (error) {
        print(error);
      }
      expect(success, true);
      expect(await LoginModel.loadDoSaveId(), doSaveId);
    });
  });
  group('[Method] writeSavedId', () {
    SharedPreferences.setMockInitialValues({});
    test('should write savedId variable', () async {
      bool success = false;
      try {
        await LoginModel.writeSavedId(savedId);
        success = true;
      } catch (error) {
        print(error);
      }
      expect(success, true);
      expect(await LoginModel.loadSavedId(), savedId);
    });
  });
}
