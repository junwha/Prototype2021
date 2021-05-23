import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const kGoogleApiKey = "AIzaSyBhcuH45NaLJEqVuqGG7EmPqPPIJq9kumc";

// Types of places
class PlaceType {
  static const String RESTAURANT = "식당";
  static const String HOTEL = "호텔";
  static const String SPOT = "관광지";
  static const String CAFFEE = "카페";
  static const String DEFAULT = "default";
}

class PlaceLoader {
  LatLng center;

  List types = [
    PlaceType.RESTAURANT,
    PlaceType.HOTEL,
    PlaceType.SPOT,
    PlaceType.CAFFEE
  ];

  PlaceLoader({required this.center});

  void updateCenter(LatLng center) {
    this.center = center;
  }

  /* 
  * Find nearby places from [center] with specified type 
  */
  Future<List<PlaceData>> getPlace(String type, {int radius = 500}) async {
    if (types.contains(type)) {
      String url =
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${center.latitude},${center.longitude}&keyword=$type&radius=${radius}&key=$kGoogleApiKey";
      print(url);
      try {
        http.Response res = await http.get(Uri.parse(url));
        return parseData(res.body, type);
      } catch (e) {
        print("check internet");
        throw Exception;
      }
    } else {
      throw Exception;
    }
  }

  /* 
  * Find nearby places from [center] with specified types
  */
  Future<List<PlaceData>> getPlaces(List typeList, {int radius = 500}) async {
    List<PlaceData> placeList = [];
    for (String type in typeList) {
      placeList.addAll(await getPlace(type, radius: radius));
    }
    return placeList;
  }

  List<PlaceData> parseData(String jsonString, String type) {
    Map<String, dynamic> result = jsonDecode(jsonString);
    List<PlaceData> placeList = [];

    if (result.containsKey("next_page_token")) {
      //TODO(junwha): implement next page getter; search with more limited range
    }

    try {
      for (var placeMeta in result['results']) {
        placeList.add(PlaceData(placeMeta, type));
      }
    } catch (e) {
      print(e);
      print(result);
    }
    return placeList;
  }
}

/*
* This class saves all data of place from google map
*/
class PlaceData {
  Map<String, dynamic>
      placeMeta; //{business_status, geometry: {location: lat, lng,}, viewport: {northeast, southest}, icon, name, opening_hours, photos, place_id, plus_code: {compound_code, global_code}, price_level, rating, reference, scope, types, user_ratings_total, vicinty}
  String type;

  PlaceData(this.placeMeta, this.type);

  LatLng get location => LatLng(placeMeta["geometry"]["location"]["lat"],
      placeMeta["geometry"]["location"]["lng"]);

  String get name => placeMeta["name"];
  String get businessStatus => placeMeta["business_status"];
}
