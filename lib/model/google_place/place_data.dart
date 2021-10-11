import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/loader/google_place/google_place_loader.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/settings/constants.dart';

/* 
 * DTO object from Google Places Response
 */
class GooglePlaceData {
  Map<String, dynamic>
      placeMeta; //{business_status, geometry: {location: lat, lng,}, viewport: {northeast, southest}, icon, name, opening_hours, photos, place_id, plus_code: {compound_code, global_code}, price_level, rating, reference, scope, types, user_ratings_total, vicinty}
  String type;

  GooglePlaceData(this.placeMeta, this.type);

  LatLng get location => LatLng(placeMeta["geometry"]["location"]["lat"],
      placeMeta["geometry"]["location"]["lng"]);

  String get name => placeMeta["name"] ?? "";
  String get businessStatus => placeMeta["business_status"];
  String get userRatingsTotal => placeMeta["user_ratings_total"];
  String get types => placeMeta["types"];
  String? get photo => placeMeta.containsKey("photos")
      ? "https://maps.googleapis.com/maps/api/place/photo?photoreference=${placeMeta["photos"][0]["photo_reference"]}&key=$kGoogleApiKey&maxwidth=200"
      : null;
  String get placeId => placeMeta["place_id"];
  String? get address => placeMeta.containsKey("formatted_address")
      ? placeMeta["formatted_address"]
      : null;
}

// /*
//  * DTO object from Google Geocoding Response
//  */
// class GoogleAddressData extends GooglePlaceData {
//   Map<String, dynamic> addressMeta;
//   GoogleAddressData(this.addressMeta) : super(addressMeta, PlaceType.DEFAULT);

//   String get address => addressMeta["formatted_address"];
// }

/*
 * DTO object from TB Event Place Response
 */
class EventPlaceData {
  final DateTimeRange period;
  final int id;
  final int hearts;
  final int comments;
  final LatLng latLng;
  final String name;
  const EventPlaceData(
      this.id, this.name, this.hearts, this.comments, this.latLng, this.period);
}
