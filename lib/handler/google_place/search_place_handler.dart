import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prototype2021/handler/google_place/content_map_handler.dart';
import 'package:prototype2021/loader/google_place/google_place_loader.dart';
import 'package:prototype2021/model/google_place/place_data.dart';

import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/utils/logger/logger.dart';
import 'package:prototype2021/widgets/maps/location_result_card.dart';

const kGoogleApiKey = "AIzaSyBhcuH45NaLJEqVuqGG7EmPqPPIJq9kumc";

class SearchPlaceModel with ChangeNotifier {
  List<GooglePlaceData> searchResult = []; // save search result data
  List<LocationResultCard> resultCards = []; // save resultCards UI's

  ContentMapHandler locationModel;

  SearchPlaceModel(this.locationModel);

  void searchPlace(String keyword) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?key=$kGoogleApiKey&input=$keyword&inputtype=textquery&fields=photos,place_id,name,geometry"; // TODO: set locationbias

    try {
      http.Response res = await http.get(Uri.parse(url));
      searchResult = parseData(res.body);
    } catch (e) {
      Logger.errorWithInfo(
          "check internet", "search_place_handler.dart -> searchPlace");
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
          Logger.group2("Card clicked");
        },
      ));
    }
  }
}
