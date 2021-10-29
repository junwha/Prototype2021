import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/model/board/place_data_props.dart';
import 'package:prototype2021/model/board/pseudo_place_data.dart';
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

  List<LatLng> get _polylinePoints =>
      this.locations.map((l) => l.latLng).toList();

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
  void updatePlaceData(List<List<PlaceDataInterface>> placeItemsPerDay) {
    Logger.group1(placeItemsPerDay.length);
    // Copy PlaceData
    this.placeItemsPerDay = List.generate(
        placeItemsPerDay.length, (index) => List.from(placeItemsPerDay[index]));

    // Remove non-PlaceData
    this.placeItemsPerDay = this.placeItemsPerDay.map((placeDataList) {
      placeDataList.removeWhere((element) => !(element is PseudoPlaceData));
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
    this.updateLocations([]);
    if (placeItemsPerDay.length == 0) return;

    List<PlaceDataInterface> placeItems = placeItemsPerDay[day - 1];

    if (mapLoaded) {
      // Update Marker with data of placeItems
      this.updateLocations(placeItems.map((e) => IndexLocation(
          placeItems.indexOf(e),
          LatLng(e.location.latitude, e.location.longitude),
          e.types,
          e.name)));

      if (placeItems.length > 0) {
        // Calculate mean point
        double meanLatitude = placeItems
                .map((e) => e.location.latitude)
                .reduce((value, element) => value + element) /
            placeItems.length;
        double meanLongitude = placeItems
                .map((e) => e.location.longitude)
                .reduce((value, element) => value + element) /
            placeItems.length;

        // Update center as mean point
        this.updateCenter(LatLng(meanLatitude, meanLongitude));
      }
    }
  }
}
