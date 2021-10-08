import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/utils/simple_storage/simple_storage.dart';

class UserInfoHandler with ChangeNotifier {
  Future<void> getCurrentLocation() async {
    Geolocator.getCurrentPosition()
        .then((position) => LatLng(position.latitude, position.longitude));
  }

  UserInfoHandler() {
    getCurrentLocation();
  }

  LatLng _currentLocation = LatLng(37.5642135, 127.0016985);
  String? _jwtToken;
  int? _userId;

  /// API 통신에 필요한 JWT 토큰
  String? get token => _jwtToken;

  /// 유저의 ID
  int? get userId => _userId;

  /// 유저의 현재 위치. 로딩 되지 않았을 때 default는 서울
  LatLng get currentLocation => _currentLocation;

  /// token Setter
  void setToken(String? jwtToken) {
    _jwtToken = jwtToken;
    notifyListeners();
  }

  /// userId Setter
  void setId(int? id) {
    _userId = id;
    notifyListeners();
  }

  /// currentLocation Setter
  void setCurrentLocation(LatLng location) {
    _currentLocation = location;
    notifyListeners();
  }

  /// 디바이스에 JWT 토큰을 저장합니다
  Future<void> saveToken(String token) async =>
      await SimpleStorage.writeString(SimpleStorageKeys.jwtToken, token);

  /// 디바이스의 유저의 ID를 저장합니다
  Future<void> saveId(int id) async =>
      await SimpleStorage.writeInt(SimpleStorageKeys.userId, id);

  /// 디바이스에 저장된 JWT 토큰을 불러와 모델(UserInfoModel)에 저장합니다
  /// 토큰이 없거나 불러오는데 오류가 발생하면 token을 null로 저장합니다
  Future<void> loadToken() async =>
      setToken(await SimpleStorage.readString(SimpleStorageKeys.jwtToken));

  /// 디바이스에 저장된 유저의 ID를 불러와 모델(UserInfoModel)에 저장합니다
  /// 토큰이 없거나 불러오는데 오류가 발생하면 userId를 null로 저장합니다
  Future<void> loadUserId() async =>
      setId(await SimpleStorage.readInt(SimpleStorageKeys.userId));
}
