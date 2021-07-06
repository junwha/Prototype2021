import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:prototype2021/model/map/google_place_loader.dart';
import 'package:prototype2021/model/map/place_data.dart';
import 'package:prototype2021/model/map/location.dart';

import 'package:prototype2021/theme/map/marker.dart';

class LocationModel with ChangeNotifier {
  List<Location> locations = [];
  Location? clickedLocation;

  Map<String, bool> isIncludeType = {
    PlaceType.RESTAURANT: false,
    PlaceType.HOTEL: false,
    PlaceType.SPOT: false,
    PlaceType.CAFFEE: false,
  };
  MarkerList markerList = MarkerList();

  bool mapLoaded = false;
  LatLng center;
  late PlaceLoader placeLoader;
  GoogleMapController? mapController;

  int radius = 1500;

  bool placeLoaded = false;

  LocationModel({required this.center}) {
    init();
  }

  void init() async {
    mapLoaded = await markerList.loadImage(); // Load Marker Icons
    this.placeLoader = PlaceLoader(center: this.center);
    notifyListeners();
  }

  /*
   * Clear all markers, locations
   */
  void clearMap() {
    locations.clear();
    markerList.removeAll();
    notifyListeners();
  }

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
   * Find plcae of point and update clicked location
   */
  Future<void> findPlace(LatLng point) async {
    GooglePlaceData? placeData = await this.placeLoader.getOnePlace(point);
    if (placeData != null) {
      GooglePlaceLocation location = GooglePlaceLocation.fromData(placeData);
      locations.add(location);
      locations.remove(this.clickedLocation);
      this.clickedLocation = location;
      updateMarkers();
      markerList.changeFocus(location);
      updateCenter(location.latLng);
      notifyListeners();
    }
  }

  /*
   * Load Places with types and update locations  
   */
  Future<void> loadPlaces() async {
    placeLoaded = false;
    clearMap();
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

    // Find nearby places with specified types
    for (GooglePlaceData placeData in placeDataList) {
      // Add all placeData to location list
      locations.add(GooglePlaceLocation.fromData(placeData));
    }

    if (types.isNotEmpty) {
      updateMarkers();
    }
    placeLoaded = true;
    notifyListeners();
  }

  Set<Marker> get markers =>
      markerList.markerList; //TODO: consider update location with efficiency

  /*
   * Update bearing and rotate markers
   */
  void updateBearing(double bearing) {
    if (markerList.bearing != bearing) {
      markerList.bearing = bearing;
      updateMarkers();
    }
    placeLoaded = true;
    notifyListeners();
  }

  /*
   * Update locations field with the locations included in boundary of bounds.
   */
  void updateLocations(LatLngBounds bounds) {
    //TODO(junwha): call this method when map changed action detected.
    //bounds.southwest; bounds.northeast;

    if (isUpdate(bounds)) {
      notifyListeners();
    } else {}
  }

  void updateMarkers() {
    markerList.removeAll();
    markerList.addMarkerList(locations);
  }

  void updateCenter(LatLng center) {
    this.center = center;
    mapController?.moveCamera(
      CameraUpdate.newLatLng(center),
    );
    notifyListeners();
  }

  /*
   * When user clicked search result, this method would be called.
   */
  void moveToResult(GooglePlaceData data) {
    clearMap();
    updateCenter(data.location);
    Location location = GooglePlaceLocation(data.placeId, data.photo, data.name,
        data.address, data.location, PlaceType.DEFAULT);
    locations = [location];
    updateMarkers();
    this.markerList.changeFocus(location);
    clearFilters();
    notifyListeners();
  }

  void removeFocus() {
    markerList.changeFocus(null);
    notifyListeners();
  }

  bool isFocused() {
    if (markerList.focusedLocation == null) return false;
    return true;
  }

  bool isUpdate(LatLngBounds bounds) {
    return false;
  }
}
