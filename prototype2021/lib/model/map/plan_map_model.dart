import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/data/location.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/loader/google_place_loader.dart';
import 'package:prototype2021/model/map/tb_map_model.dart';

class PlanMapModel extends TBMapModel {
  List<LatLng> get _polylinePoints =>
      this.locations.map((l) => l.latLng).toList();

  Polyline? get polyline => Polyline(
        polylineId: PolylineId("0"),
        points: _polylinePoints,
        color: Colors.black,
        width: 3,
        patterns: [PatternItem.dash(10), PatternItem.gap(10)],
      );

  PlanMapModel(LatLng center) : super(center);

  void updatePolyline(List<PlaceDataProps> placeItems) async {
    if (placeItems.length > 0 && mapLoaded) {
      double meanLatitude = placeItems
              .map((e) => e.location.latitude)
              .reduce((value, element) => value + element) /
          placeItems.length;
      double meanLongitude = placeItems
              .map((e) => e.location.longitude)
              .reduce((value, element) => value + element) /
          placeItems.length;

      this.changeFocus(Location(LatLng(meanLatitude, meanLongitude),
          PlaceType.DEFAULT, "center of polyline"));

      this.updateLocations(placeItems.map((e) => Location(
          LatLng(e.location.latitude, e.location.longitude), e.types, e.name)));
    }
  }
}
