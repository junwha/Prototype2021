import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/data/location.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/loader/google_place_loader.dart';
import 'package:prototype2021/model/map/tb_map_model.dart';
import 'package:prototype2021/theme/map/plan_marker.dart';

class PlanMapModel extends TBMapModel {
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
  PlanMapModel(LatLng center) : super(center, markerList: PlanMarker());

  /*
   * This method updates polyline data with placeItems from outer model
   * Please add this method as another model's notifier 
   * Example: handler.addNotifier((){updatePolyline(handler.placeItems){...}});
   */
  void updatePolyline(List<PlaceDataProps> placeItems) async {
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
