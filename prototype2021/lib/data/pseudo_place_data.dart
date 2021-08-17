import 'dart:math';

import 'package:geodesy/geodesy.dart';
import 'package:prototype2021/data/place_data_props.dart';

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
      types: "attraction",
      address: "중국, 상하이"),
  PseudoPlaceData(
      location: randomLocation(),
      name: "루브르 박물관",
      types: "attraction",
      address: "프랑스, 파리"),
  PseudoPlaceData(
      location: randomLocation(),
      name: "그라니트 자카",
      types: "attraction",
      address: "스위스, 베른"),
  PseudoPlaceData(
      location: randomLocation(),
      name: "000 호텔",
      types: "accomodations",
      address: "스위스, 베른"),
  PseudoPlaceData(
      location: randomLocation(),
      name: "RESTAURANT",
      types: "restaurant",
      address: "프랑스, 파리"),
  PseudoPlaceData(
      location: randomLocation(),
      name: "Starbucks",
      types: "cafe",
      address: "미국, 뉴욕"),
];
