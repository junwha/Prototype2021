import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:prototype2021/model/location.dart';
import 'package:prototype2021/model/location_model.dart';
import 'package:prototype2021/model/map_place.dart';
import 'package:prototype2021/model/place_data.dart';
import 'package:prototype2021/settings/constants.dart';
import 'dart:convert';

import 'package:prototype2021/ui/location_result_card.dart';

const kGoogleApiKey = "AIzaSyBhcuH45NaLJEqVuqGG7EmPqPPIJq9kumc";

class SearchPlaceModel with ChangeNotifier {
  List<GooglePlaceData> searchResult = []; // save search result data
  List<LocationResultCard> resultCards = []; // save resultCards UI's

  LocationModel locationModel;

  SearchPlaceModel(this.locationModel);

  void searchPlace(String keyword) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?key=$kGoogleApiKey&input=$keyword&inputtype=textquery&fields=photos,place_id,name,geometry"; // TODO: set locationbias

    try {
      http.Response res = await http.get(Uri.parse(url));
      searchResult = await parseData(res.body);
    } catch (e) {
      print("check internet");
    }
    updateLocationResultCards();
    notifyListeners();
  }

  List<GooglePlaceData> parseData(String jsonString) {
    Map<String, dynamic> result = jsonDecode(jsonString);
    searchResult.clear();

    for (var searchResultMeta in result['candidates']) {
      searchResult.add(GooglePlaceData(searchResultMeta, PlaceType.DEFAULT));
    }

    return searchResult;
  }

  void updateLocationResultCards() {
    resultCards.clear();

    for (var data in searchResult) {
      resultCards.add(LocationResultCard(
        name: data.name,
        image: Image(
          image: NetworkImage(data.photo ?? placeHolder),
          fit: BoxFit.cover,
        ),
        onclick: () {
          this.locationModel.moveToResult(data);
          this.resultCards = [];
          print("Card clicked");
        },
      ));
    }
  }
}
