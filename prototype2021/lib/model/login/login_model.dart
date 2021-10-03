import 'package:prototype2021/utils/simple_storage/simple_storage.dart';

class LoginModel {
  static Future<bool> loadAutoLogin() async =>
      await SimpleStorage.readBool(SimpleStorageKeys.autoLogin) ?? false;

  static Future<bool> loadDoSaveId() async =>
      await SimpleStorage.readBool(SimpleStorageKeys.doSaveId) ?? false;

  static Future<String?> loadSavedId() async =>
      await SimpleStorage.readString(SimpleStorageKeys.savedId);

  static Future<void> writeAutoLogin(bool autoLogin) async =>
      await SimpleStorage.writeBool(SimpleStorageKeys.autoLogin, autoLogin);

  static Future<void> writeDoSaveId(bool doSaveId) async =>
      await SimpleStorage.writeBool(SimpleStorageKeys.doSaveId, doSaveId);

  static Future<void> writeSavedId(String savedId) async =>
      await SimpleStorage.writeString(SimpleStorageKeys.savedId, savedId);
}
