import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/theme/map/marker.dart';

class TBMapModel with ChangeNotifier {
  bool mapLoaded = false;

  LatLng center;

  MarkerList markerList = MarkerList();
  Set<Location> locations = {};
  GoogleMapController? mapController;

  TBMapModel(this.center) {
    init();
  }

  Set<Marker> get markers =>
      markerList.markerList; //TODO: consider update location with efficiency

  void init() async {
    mapLoaded = await markerList.loadImage(); // Load Marker Icons
    notifyListeners();
  }

  void updateCenter(LatLng center) {
    this.center = center;
    mapController?.moveCamera(
      CameraUpdate.newLatLng(center),
    );
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

  void updateMarkers() {
    markerList.removeAll();
    markerList.addMarkers(locations);
    notifyListeners();
  }

  void updateLocations(Iterable<Location> locationIterable) {
    Set<Location> newLocations = locationIterable.toSet();
    markerList.removeMarkers(locations.difference(newLocations));
    markerList.addMarkers(newLocations.difference(locations));
    locations = newLocations;
    notifyListeners();
  }

  void addLocations(Iterable<Location> locationIterable) {
    Set<Location> newLocations = locationIterable.toSet();
    markerList.addMarkers(newLocations.difference(locations));
    locations.addAll(newLocations);
    notifyListeners();
  }

  void removeLocations(Iterable<Location> locationIterable) {
    markerList.removeMarkers(locationIterable);
    locations.removeAll(locationIterable);
    notifyListeners();
  }

  /*
   * Update bearing and rotate markers
   */
  void updateBearing(double bearing) {
    if (markerList.bearing != bearing) {
      markerList.bearing = bearing;
      updateMarkers();
    }
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

  /*
   * (Not implemented) 
   */
  bool isUpdate(LatLngBounds bounds) {
    return false;
  }

  /*
   * (Not implemented) Update locations field with the locations included in boundary of bounds.
   */
  void updateBound(LatLngBounds bounds) {
    //TODO(junwha): call this method when map changed action detected.
    //bounds.southwest; bounds.northeast;

    if (isUpdate(bounds)) {
      notifyListeners();
    } else {}
  }
}
