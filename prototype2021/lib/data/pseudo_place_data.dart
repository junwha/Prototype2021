import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/views/event/loader/google_place_loader.dart';

// class GooglePlaceData {
//   Map<String, dynamic>
//       placeMeta; //{business_status, geometry: {location: lat, lng,}, viewport: {northeast, southest}, icon, name, opening_hours, photos, place_id, plus_code: {compound_code, global_code}, price_level, rating, reference, scope, types, user_ratings_total, vicinty}
//   String type;

//   GooglePlaceData(this.placeMeta, this.type);

//   LatLng get location => LatLng(placeMeta["geometry"]["location"]["lat"],
//       placeMeta["geometry"]["location"]["lng"]);

//   String get name => placeMeta["name"];
//   String get businessStatus => placeMeta["business_status"];
//   String get userRatingsTotal => placeMeta["user_ratings_total"];
//   String get types => placeMeta["types"];
//   String? get photo => placeMeta.containsKey("photos")
//       ? "https://maps.googleapis.com/maps/api/place/photo?photoreference=${placeMeta["photos"][0]["photo_reference"]}&key=$kGoogleApiKey&maxwidth=200"
//       : null;
//   String get placeId => placeMeta["place_id"];
//   String? get address => placeMeta.containsKey("formatted_address")
//       ? placeMeta["formatted_address"]
//       : null;
// }

class PseudoPlaceData implements PlaceDataProps {
  LatLng location;
  String name;
  String businessStatus;
  String userRatingsTotal;
  String types; // attraction, accomodations, restaurant, cafe, memo
  String? photo;
  String placeId;
  String? address;
  String memo; // Just For Memo

  PseudoPlaceData({
    required this.location,
    required this.name,
    required this.types,
    required this.address,
    this.businessStatus = "영업중",
    this.userRatingsTotal = "",
    this.placeId = "pseudo-place-id",
    this.photo = "",
    this.memo = "",
  });
}

LatLng randomLocation() {
  return LatLng(Random().nextDouble() * 0.02, Random().nextDouble() * 0.02);
}

List<PseudoPlaceData> pseudoPlaceData = [
  PseudoPlaceData(
      location: randomLocation(),
      name: "상하이 디즈니랜드",
      types: PlaceType.SPOT,
      address: "중국, 상하이"),
  PseudoPlaceData(
      location: randomLocation(),
      name: "루브르 박물관",
      types: PlaceType.SPOT,
      address: "프랑스, 파리"),
  PseudoPlaceData(
      location: randomLocation(),
      name: "그라니트 자카",
      types: PlaceType.SPOT,
      address: "스위스, 베른"),
  PseudoPlaceData(
      location: randomLocation(),
      name: "000 호텔",
      types: PlaceType.HOTEL,
      address: "스위스, 베른"),
  PseudoPlaceData(
      location: randomLocation(),
      name: "RESTAURANT",
      types: PlaceType.RESTAURANT,
      address: "프랑스, 파리"),
  PseudoPlaceData(
      location: randomLocation(),
      name: "Starbucks",
      types: PlaceType.CAFE,
      address: "미국, 뉴욕"),
];

PlanDataProps pseudoPlanData = PseudoPlanData(
  "Tripbuilder",
  "울산광역시",
  DateTimeRange(start: DateTime(2020, 06, 23), end: DateTime(2021, 10, 31)),
  "100만원",
  true,
  ["맛집탐방", "SNS핫플", "인생사진"],
  [
    [pseudoPlaceData[0], pseudoPlaceData[1]],
    [pseudoPlaceData[3]],
    [pseudoPlaceData[2], pseudoPlaceData[4], pseudoPlaceData[0]],
    [pseudoPlaceData[2], MemoData(memo: "asdf"), pseudoPlaceData[0]]
  ],
);
