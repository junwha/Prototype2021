import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/data/location.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/loader/google_place_loader.dart';
import 'package:prototype2021/model/map/tb_map_model.dart';

class PlanMapModel extends TBMapModel {
  List<PlaceDataProps> placeItems;
  List<LatLng> get _polylinePoints =>
      this.locations.map((l) => l.latLng).toList();

  Polyline? get polyline => Polyline(
        polylineId: PolylineId("0"),
        points: _polylinePoints,
        color: Colors.black,
        width: 3,
        patterns: [PatternItem.dash(10), PatternItem.gap(10)],
      );

  PlanMapModel(LatLng center, this.placeItems) : super(center) {
    testPolyline();
  }

  void testPolyline() async {
    await this.markerList.loadImage();
    this.updateLocations(placeItems.map((e) => Location(
        LatLng(e.location.latitude, e.location.longitude),
        PlaceType.CAFFEE,
        e.name)));
  }
}
