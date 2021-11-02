import 'dart:async';
import 'dart:math' show asin, cos, sqrt;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/board/place_data_props.dart';
import 'package:prototype2021/utils/google_map/handler/location.dart';
import 'package:prototype2021/utils/google_map/widgets/marker.dart';
import 'package:prototype2021/utils/logger/logger.dart';
import 'package:prototype2021/utils/safe_http/common.dart';

class TBMapHandler with ChangeNotifier {
  bool mapLoaded = false;
  Function() mapLoadListener = () {};

  MarkerList markerList;

  LatLng center;

  /// Map controller must be checked whether it is initialized
  /// If you ensure mapController is initialized, you can use this mapController with ! operator.
  Completer<GoogleMapController> mapController = Completer();

  /// Generally, TBMapModel start with its own plain MarkerList.
  /// However, if you have the child implements of MarkerList, inject the MarkerList into this model.
  TBMapHandler(this.center, {MarkerList? markerList})
      : this.markerList = nullable<MarkerList>(markerList) ?? MarkerList() {
    init();
  }

  Set<Marker> get markers =>
      markerList.markerList; // TODO: consider update location with efficiency

  // Markerized Location Set
  Set<Location> get locations => markerList.markers.keys.toSet();

  void setMapLoadListener(Function() mapLoadListener) {
    this.mapLoadListener = mapLoadListener;
  }

  /// init() function of TBMapModel loads the marker images when this Object is constructed
  /// if you want to override init() function, please call super.init() inside the function.
  void init() async {
    mapLoaded = await markerList.loadImage(); // Load Marker Icons
    mapLoadListener.call();

    notifyListeners();
  }

  /// Update center and move the camera to newer center.
  Future<void> updateCenterByLatLngBound(
      List<PlaceDataInterface> placeItems) async {
    final GoogleMapController controller = await mapController.future;
    LatLngBounds bounds = _calculateBound(placeItems);
    if (bounds.southwest == bounds.northeast) {
      updateCenterByLatLng(bounds.southwest);
      return;
    }
    Logger.group1("Updating center with bounds");
    LatLng centerBound = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );
    double zoomLevel =
        await _calculateZoomLevel(controller, bounds, centerBound);
    updateCenterByLatLng(centerBound, zoomLevel);
    // controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    // await _zoomToFit(controller, bounds, centerBound);
    // notifyListeners();
  }

  Future<void> updateCenterByLatLng(LatLng _center, [double? zoomLevel]) async {
    Logger.group1("Updating center with latlng");
    center = _center;
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: center, zoom: zoomLevel ?? 13),
      ),
    );
    notifyListeners();
  }

  /// Clear all markers from the map
  void clearMap() {
    markerList.removeAll();
    notifyListeners();
  }

  /// DEPRECATED
  void _updateMarkers() {
    markerList.removeAll();
    markerList.addMarkers(locations);
    notifyListeners();
  }

  /// Remove previous locations and update with new locations.
  /// updateLocations remove all diffrence locations form the marker set,
  /// and add only newer locations to the marker set.
  void updateLocations(Iterable<Location> locationIterable) {
    Set<Location> newLocations = locationIterable.toSet();
    Set<Location> oldLocations = locations;
    markerList.removeMarkers(oldLocations.difference(newLocations));
    markerList.addMarkers(newLocations.difference(oldLocations));

    notifyListeners();
  }

  /// Add new locations without erase older markers
  /// Only newer locations will be added to the marker set.
  void addLocations(Iterable<Location> locationIterable) {
    Set<Location> newLocations = locationIterable.toSet();
    Set<Location> oldLocations = locations;
    markerList.addMarkers(newLocations.difference(oldLocations));
    locations.addAll(newLocations);
    notifyListeners();
  }

  /// Remove specific locations from the marker set.
  void removeLocations(Iterable<Location> locationIterable) {
    markerList.removeMarkers(locationIterable);
    notifyListeners();
  }

  /// Update bearing and rotate markers
  void updateBearing(double bearing) {
    if (markerList.bearing != bearing) {
      markerList.bearing = bearing;
      redrawMap();
    }
    notifyListeners();
  }

  /// Redraw all markers
  void redrawMap() {
    Iterable<Location> locationTemp = locations;
    clearMap();
    updateLocations(locationTemp);
  }

  /// Change focus to specific location.
  /// camera will be moved to the target lcation.
  Future<void> changeFocus(Location location) async {
    markerList.changeFocus(location);
    await updateCenterByLatLng(location.latLng);
    notifyListeners();
  }

  /// Remove focus.
  void removeFocus() {
    markerList.changeFocus(null);
    notifyListeners();
  }

  bool isFocused() {
    return markerList.focusedLocation != null;
  }

  LatLngBounds _calculateBound(List<PlaceDataInterface> placeItems) {
    // Initialization
    double latMin = placeItems[0].location.latitude;
    double latMax = placeItems[0].location.latitude;
    double longMin = placeItems[0].location.longitude;
    double longMax = placeItems[0].location.longitude;

    // Calculating
    placeItems.forEach((placeItem) {
      if (placeItem.location.latitude > latMax)
        latMax = placeItem.location.latitude;
      if (placeItem.location.latitude < latMin)
        latMin = placeItem.location.latitude;
      if (placeItem.location.longitude > longMax)
        longMax = placeItem.location.longitude;
      if (placeItem.location.longitude < longMin)
        longMin = placeItem.location.longitude;
    });

    return LatLngBounds(
        southwest: LatLng(latMin, longMin), northeast: LatLng(latMax, longMax));
  }

  Future<double> _calculateZoomLevel(GoogleMapController controller,
      LatLngBounds bounds, LatLng centerBounds) async {
    bool keepZoomingOut = true;
    double zoomLevel = await controller.getZoomLevel();

    while (keepZoomingOut) {
      final LatLngBounds screenBounds = await controller.getVisibleRegion();
      if (_fits(bounds, screenBounds)) {
        keepZoomingOut = false;
        zoomLevel = await controller.getZoomLevel() - 0.5;
        break;
      } else {
        // Zooming out by 0.1 zoom level per iteration
        zoomLevel = await controller.getZoomLevel() - 0.1;
      }
    }
    return zoomLevel;
  }

  bool _fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
    final bool northEastLatitudeCheck =
        screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
    final bool northEastLongitudeCheck =
        screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

    final bool southWestLatitudeCheck =
        screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
    final bool southWestLongitudeCheck =
        screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

    return northEastLatitudeCheck &&
        northEastLongitudeCheck &&
        southWestLatitudeCheck &&
        southWestLongitudeCheck;
  }

  /// (Not implemented)
  // bool isUpdate(LatLngBounds bounds) {
  //   return false;
  // }

  /// (Not implemented) Update locations field with the locations included in boundary of bounds.
  // void updateBound(LatLngBounds bounds) {
  //   // TODO(junwha): call this method when map changed action detected.
  //   // bounds.southwest; bounds.northeast;

  //   if (isUpdate(bounds)) {
  //     notifyListeners();
  //   } else {}
  // }
}
