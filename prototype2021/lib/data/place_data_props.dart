/* 
 * 차후 API에서 오는 데이터에 맞게 이 추상 클래스를 바꿔서 이용해주세요!
 * 현재는 PseudoPlaceData가 이 추상 클래스를 implement하고 있습니다
*/
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class PlaceDataProps {
  abstract LatLng location;
  abstract String name;
  abstract String businessStatus;
  abstract String userRatingsTotal;
  abstract String types; // attraction, accomodations, restaurant, cafe, memo
  abstract String? photo;
  abstract String placeId;
  abstract String? address;
  abstract String memo; // Just For Memo
}

class MemoData implements PlaceDataProps {
  late LatLng location;
  late String name;
  late String businessStatus;
  late String userRatingsTotal;
  String types; // attraction, accomodations, restaurant, cafe, memo
  late String? photo;
  late String placeId;
  late String? address;
  String memo; // Just For Memo

  MemoData({
    required this.memo,
  }) : types = "memo" {
    name = "";
    businessStatus = "";
    userRatingsTotal = "";
    placeId = "memo";
    location = LatLng(0, 0);
  }
}
