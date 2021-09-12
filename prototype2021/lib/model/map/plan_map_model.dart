import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/data/location.dart';
import 'package:prototype2021/loader/google_place_loader.dart';
import 'package:prototype2021/model/map/tb_map_model.dart';

class PlanMapModel extends TBMapModel {
  List<LatLng> get _polylinePoints =>
      this.locations.map((l) => l.latLng).toList();

  Polyline? get polyline => Polyline(
        polylineId: PolylineId("0"),
        points: _polylinePoints,
        color: Colors.cyan,
        width: 8,
        patterns: [PatternItem.dash(10), PatternItem.gap(10)],
      );

  PlanMapModel(LatLng center) : super(center) {
    initPlan();
  }

  void initPlan() async {
    await this.markerList.loadImage();
    this.addLocations([
      Location(LatLng(35.5763, 129.1593), PlaceType.CAFFEE, "1"),
      Location(LatLng(35.5864, 129.1892), PlaceType.CAFFEE, "2"),
      Location(LatLng(35.5960, 129.1591), PlaceType.CAFFEE, "3"),
      Location(LatLng(35.5863, 129.1890), PlaceType.CAFFEE, "4"),
    ]);
  }
}
