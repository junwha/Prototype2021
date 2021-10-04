import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/utils/google_map/handler/location.dart';
import 'package:prototype2021/utils/google_map/widgets/marker.dart';

class TBMapHandler with ChangeNotifier {
  bool mapLoaded = false;
  Function() mapLoadListener = () {};

  LatLng center;

  MarkerList markerList = MarkerList();

  // Map controller must be checked whether it is initialized
  // If you ensure mapController is initialized, you can use this mapController with ! operator.
  GoogleMapController? mapController;

  /*
   * Generally, TBMapModel start with its own plain MarkerList.
   * However, if you have the child implements of MarkerList, inject the MarkerList into this model.
   */
  TBMapHandler(this.center, {MarkerList? markerList}) {
    if (markerList != null) {
      this.markerList = markerList;
    }

    init();
  }

  Set<Marker> get markers =>
      markerList.markerList; //TODO: consider update location with efficiency

  // Markerized Location Set
  Set<Location> get locations => markerList.markers.keys.toSet();

  void setMapLoadListener(Function() mapLoadListener) {
    this.mapLoadListener = mapLoadListener;
  }

  /*
   * init() function of TBMapModel loads the marker images when this Object is constructed
   * if you want to override init() function, please call super.init() inside the function.
   */
  void init() async {
    mapLoaded = await markerList.loadImage(); // Load Marker Icons
    mapLoadListener.call();

    notifyListeners();
  }

  /*
   * Update center and move the camera to newer center.
   */
  void updateCenter(LatLng center) {
    this.center = center;
    mapController?.moveCamera(
      CameraUpdate.newLatLng(center),
    );
    notifyListeners();
  }

  /*
   * Clear all markers from the map
   */
  void clearMap() {
    markerList.removeAll();
    notifyListeners();
  }

  /*
   * Deprecated method
   */
  void _updateMarkers() {
    markerList.removeAll();
    markerList.addMarkers(locations);
    notifyListeners();
  }

  /*
   * Remove previous locations and update with new locations.
   * updateLocations remove all diffrence locations form the marker set,
   * and add only newer locations to the marker set.
   */
  void updateLocations(Iterable<Location> locationIterable) {
    Set<Location> newLocations = locationIterable.toSet();
    Set<Location> oldLocations = locations;
    markerList.removeMarkers(oldLocations.difference(newLocations));
    markerList.addMarkers(newLocations.difference(oldLocations));

    notifyListeners();
  }

  /*
   * Add new locations without erase older markers
   * Only newer locations will be added to the marker set.
   */
  void addLocations(Iterable<Location> locationIterable) {
    Set<Location> newLocations = locationIterable.toSet();
    Set<Location> oldLocations = locations;
    markerList.addMarkers(newLocations.difference(oldLocations));
    locations.addAll(newLocations);
    notifyListeners();
  }

  /*
   * Remove specific locations from the marker set.
   */
  void removeLocations(Iterable<Location> locationIterable) {
    markerList.removeMarkers(locationIterable);
    notifyListeners();
  }

  /*
   * Update bearing and rotate markers
   */
  void updateBearing(double bearing) {
    if (markerList.bearing != bearing) {
      markerList.bearing = bearing;
      redrawMap();
    }
    notifyListeners();
  }

  /*
   * Redraw all markers
   */
  void redrawMap() {
    Iterable<Location> locationTemp = locations;
    clearMap();
    updateLocations(locationTemp);
  }

  /*
   * Change focus to specific location.
   * camera will be moved to the target lcation.
   */
  void changeFocus(Location location) {
    markerList.changeFocus(location);
    updateCenter(location.latLng);
    notifyListeners();
  }

  /*
   * Remove focus.
   */
  void removeFocus() {
    markerList.changeFocus(null);
    notifyListeners();
  }

  bool isFocused() {
    return markerList.focusedLocation != null;
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
