import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:prototype2021/model/location.dart';
import 'package:prototype2021/model/location_model.dart';
import 'dart:convert';

import 'package:prototype2021/ui/location_result_card.dart';

const kGoogleApiKey = "AIzaSyBhcuH45NaLJEqVuqGG7EmPqPPIJq9kumc";

class SearchModel with ChangeNotifier {
  List<SearchResultData> searchResult = [];
  List<LocationResultCard> resultCards = [];
  LocationModel locationModel;

  SearchModel(this.locationModel);

  void searchPlace(String keyword) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?key=$kGoogleApiKey&input=$keyword&inputtype=textquery&fields=photos,place_id,name,geometry";
    //TODO: set locationbias
    try {
      http.Response res = await http.get(Uri.parse(url));
      searchResult = await parseData(res.body);
    } catch (e) {
      print("check internet");
    }
    print(searchResult);
    updateLocationResultCards();
    notifyListeners();
  }

  List<SearchResultData> parseData(String jsonString) {
    Map<String, dynamic> result = jsonDecode(jsonString);
    searchResult = [];

    for (var searchResultMeta in result['candidates']) {
      searchResult.add(SearchResultData(searchResultMeta));
    }

    return searchResult;
  }

  void updateLocationResultCards() {
    resultCards = [];
    for (var data in searchResult) {
      resultCards.add(LocationResultCard(
        name: data.name,
        image: data.loadPhoto(),
        onclick: () {
          this.locationModel.moveToResult(data.name, data.location);
          this.resultCards = [];
          print("clicked");
        },
      ));
      print(resultCards.length);
    }
  }
}

class SearchResultData {
  Map<String, dynamic>
      searchResultMeta; //{geometry: {location: lat, lng,}, viewport: {northeast, southest}, icon, name, photos, place_id}
  SearchResultData(this.searchResultMeta);

  LatLng get location => LatLng(searchResultMeta["geometry"]["location"]["lat"],
      searchResultMeta["geometry"]["location"]["lng"]);

  String get name => searchResultMeta["name"];

  Image? loadPhoto() {
    if (searchResultMeta.containsKey("photos")) {
      String photoUrl =
          "https://maps.googleapis.com/maps/api/place/photo?key=$kGoogleApiKey&photoreference=${searchResultMeta["photos"][0]["photo_reference"]}&maxheight=500";

      return Image(
        image: NetworkImage(photoUrl),
        fit: BoxFit.cover,
      );
    }
  }
}
