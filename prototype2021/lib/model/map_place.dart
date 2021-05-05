import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const kGoogleApiKey = "AIzaSyBhcuH45NaLJEqVuqGG7EmPqPPIJq9kumc";

const String RESTAURANT = "식당";
const String HOTEL = "호텔";
const String SPOT = "관광지";

class PlaceLoader {
  LatLng center;
  String? type;
  late String url =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${center.latitude},${center.longitude}&keyword=$type&radius=2000&key=$kGoogleApiKey";
  List types = [RESTAURANT, HOTEL, SPOT];

  PlaceLoader({required this.center});

  void changeCenter(LatLng center) {}

  Future<List<PlaceData>> getPlace(String type) async {
    if (types.contains(type)) {
      this.type = type;
      http.Response res = await http.get(Uri.parse(url));
      return parseData(res.body);
    } else {
      throw Exception;
    }
  }

  Future<List<PlaceData>> getPlaces(List typeList) async {
    List<PlaceData> placeList = [];
    for (String type in typeList) {
      placeList.addAll(await getPlace(type));
    }

    return placeList;
  }

  List<PlaceData> parseData(String jsonString) {
    Map<String, dynamic> result = jsonDecode(jsonString);
    List<PlaceData> placeList = [];

    if (result.containsKey("next_page_token")) {
      //TODO(junwha): implement next page getter
    }

    try {
      for (var placeMeta in result['results']) {
        placeList.add(PlaceData(placeMeta));
      }
    } catch (e) {
      print(e);
      print(result);
    }
    return placeList;
  }
}

class PlaceData {
  Map<String, dynamic>
      placeMeta; //{business_status, geometry: {location: lat, lng,}, viewport: {northeast, southest}, icon, name, opening_hours, photos, place_id, plus_code: {compound_code, global_code}, price_level, rating, reference, scope, types, user_ratings_total, vicinty}

  PlaceData(this.placeMeta);

  LatLng get location => LatLng(placeMeta["geometry"]["location"]["lat"],
      placeMeta["geometry"]["location"]["lng"]);

  String get name => placeMeta["name"];
}
