import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:prototype2021/loader/google_place_loader.dart';
import 'package:prototype2021/model/map/tb_map_model.dart';
import 'package:prototype2021/data/place_data.dart';
import 'package:prototype2021/data/location.dart';

import 'package:prototype2021/theme/map/marker.dart';

class ContentMapModel extends TBMapModel {
  Location? clickedLocation;

  Map<String, bool> isIncludeType = {
    PlaceType.RESTAURANT: false,
    PlaceType.HOTEL: false,
    PlaceType.SPOT: false,
    PlaceType.CAFFEE: false,
  };

  late PlaceLoader placeLoader;

  int radius = 1500;

  bool placeLoaded = true;

  ContentMapModel({required LatLng center}) : super(center);

  @override
  void init() {
    this.placeLoader = PlaceLoader(center: this.center);
    super.init();
  }

  /*
   * Clear all filters from the plce type list.
   */
  void clearFilters() {
    isIncludeType = {
      PlaceType.RESTAURANT: false,
      PlaceType.HOTEL: false,
      PlaceType.SPOT: false,
      PlaceType.CAFFEE: false,
    };
    notifyListeners();
  }

  /*
   * Find place of point and update clicked location
   */
  Future<void> findPlace(LatLng point) async {
    GooglePlaceData? placeData = await this.placeLoader.getOnePlace(point);
    if (placeData != null) {
      GooglePlaceLocation location = GooglePlaceLocation.fromData(placeData);
      if (clickedLocation != null) removeLocations({this.clickedLocation!});
      this.clickedLocation = location;
      addLocations([location]);
      changeFocus(location);
      notifyListeners();
    }
  }

  /*
   * Load Places with types and update locations  
   */
  Future<void> loadPlaces() async {
    placeLoaded = false;
    notifyListeners();

    this.placeLoader.updateCenter(this.center);

    List<String> types = [];

    for (String type in isIncludeType.keys) {
      if (isIncludeType[type]!) {
        types.add(type);
      }
    }
    // TODO(junwha): Get Event place
    List<GooglePlaceData> placeDataList = [];

    placeDataList =
        await placeLoader.getGooglePlaces(types, radius: this.radius);

    List<Location> locationList = [];
    // Find nearby places with specified types
    for (GooglePlaceData placeData in placeDataList) {
      // Add all placeData to location list
      locationList.add(GooglePlaceLocation.fromData(placeData));
    }

    if (types.isNotEmpty) {
      updateLocations(locationList);
    }

    placeLoaded = true;
    notifyListeners();
  }

  /*
   * When user clicked search result, this method would be called.
   */
  void moveToResult(GooglePlaceData data) {
    clearMap();
    Location location = GooglePlaceLocation(data.placeId, data.photo, data.name,
        data.address, data.location, PlaceType.DEFAULT);
    updateLocations([location]);
    clearFilters();
    changeFocus(location);
    notifyListeners();
  }
}
