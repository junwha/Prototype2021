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

  PlanMapModel(LatLng center) : super(center, markerList: PlanMarker());

  /*
   * This method updates polyline data with placeItems from outer model
   * Please add this method as another model's notifier 
   * Example: handler.addNotifier((){updatePolyline(handler.placeItems){...}});
   */
  void updatePolyline(List<PlaceDataProps> placeItems) async {
    if (mapLoaded) {
      // Update Marker with data of placeItems
      List<PlanLocation> locations = [];
      for (int i = 0; i < placeItems.length; i++) {
        int index = (i < 9) ? i : 9;

        locations.add(PlanLocation(
            index,
            LatLng(placeItems[i].location.latitude,
                placeItems[i].location.longitude),
            placeItems[i].types,
            placeItems[i].name));
      }
      this.updateLocations(locations);
      if (placeItems.length > 0) {
        // Set center as mean point
        double meanLatitude = placeItems
                .map((e) => e.location.latitude)
                .reduce((value, element) => value + element) /
            placeItems.length;
        double meanLongitude = placeItems
                .map((e) => e.location.longitude)
                .reduce((value, element) => value + element) /
            placeItems.length;
        this.updateCenter(LatLng(meanLatitude, meanLongitude));
      }
    }
  }
}
