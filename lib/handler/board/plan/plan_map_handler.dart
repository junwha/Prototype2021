import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/model/board/place_data_props.dart';
import 'package:prototype2021/utils/google_map/handler/tb_map_handler.dart';
import 'package:prototype2021/utils/google_map/widgets/plan_marker.dart';
import 'package:prototype2021/utils/logger/logger.dart';

class PlanMapHandler extends TBMapHandler {
  @override
  void dispose() {}

  void doDispose() {
    super.dispose();
  }

  List<List<PlaceDataInterface>> placeItemsPerDay = [];
  int day = 1;

  List<LatLng> get _polylinePoints => locations.map((l) => l.latLng).toList();

  Polyline? get polyline => _polylinePoints.length <= 1
      ? null
      : Polyline(
          polylineId: PolylineId("0"),
          points: _polylinePoints,
          color: Colors.black,
          width: 3,
          patterns: [
            PatternItem.dash(10),
            PatternItem.gap(10)
          ], // TODO: resolve IOS dash error
        );

  // Initialize TBMapModel with PlanMarker
  PlanMapHandler(LatLng center) : super(center, markerList: PlanMarker());

  /// Please add this method as another model's notifier
  /// Example: handler.addNotifier((){updatePolyline(handler.placeItems){...}});
  /// This method updates placeItems and call updatePolyline so that the map can be reloaded with new data
  void updatePlaceData(List<List<PlaceDataInterface>> _placeItemsPerDay) {
    Logger.group1("Updating Place Data...");
    Logger.group1(_placeItemsPerDay.length);
    // Copy PlaceData
    placeItemsPerDay = List.generate(
      _placeItemsPerDay.length,
      (index) => List.from(_placeItemsPerDay[index]),
    );

    // Remove non-PlaceData
    placeItemsPerDay = placeItemsPerDay.map((placeDataList) {
      placeDataList
          .removeWhere((element) => element.contentType == ContentType.memo);
      return placeDataList;
    }).toList();

    _updatePolyline();
    notifyListeners();
  }

  /// change the day of markers which are included in placeItemsPerDay
  void setDay(int day) {
    if (day <= placeItemsPerDay.length) {
      this.day = day;
      _updatePolyline();
      notifyListeners();
    }
  }

  // This private method update the map with its given day and placeItems
  void _updatePolyline() {
    updateLocations([]);
    Logger.group1(placeItemsPerDay.length);
    if (placeItemsPerDay.length == 0) return;

    List<PlaceDataInterface> placeItems = placeItemsPerDay[day - 1];

    if (mapLoaded) {
      Logger.group1("Updating Polyline");
      // Update Marker with data of placeItems
      updateLocations(
        placeItems.map(
          (e) => IndexLocation(
              placeItems.indexOf(e),
              LatLng(e.location.latitude, e.location.longitude),
              e.types,
              e.name),
        ),
      );

      if (placeItems.length > 0) {
        Logger.group1("Calculating Center...");
        placeItems.forEach((element) {
          Logger.group1(
              '${element.location.latitude}, ${element.location.longitude}');
        });
        // Calculate mean point
        double meanLatitude = placeItems
                .map((e) => e.location.latitude)
                .reduce((value, element) => value + element) /
            placeItems.length;
        double meanLongitude = placeItems
                .map((e) => e.location.longitude)
                .reduce((value, element) => value + element) /
            placeItems.length;

        Logger.group1("$meanLatitude, $meanLongitude");
        // Update center as mean point
        updateCenter(LatLng(meanLatitude, meanLongitude));
      }
    }
  }
}
