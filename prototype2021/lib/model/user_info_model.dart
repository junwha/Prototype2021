import 'package:flutter/material.dart';
import 'package:prototype2021/model/simple_storage.dart';

class UserInfoModel with ChangeNotifier {
  String? _jwtToken;
  int? _userId;

  String? get token => _jwtToken;
  int? get userId => _userId;

  void setToken(String? token) {
    _jwtToken = token;
    notifyListeners();
  }

  void setId(int? id) {
    _userId = id;
    notifyListeners();
  }

  Future<void> saveToken(String token) async =>
      await SimpleStorage.writeString(SimpleStorageKeys.jwtToken, token);

  Future<void> svaeId(int id) async =>
      await SimpleStorage.writeInt(SimpleStorageKeys.userId, id);

  Future<void> loadToken() async =>
      setToken(await SimpleStorage.readString(SimpleStorageKeys.jwtToken));

  Future<void> loadUserId() async =>
      setId(await SimpleStorage.readInt(SimpleStorageKeys.userId));
}
