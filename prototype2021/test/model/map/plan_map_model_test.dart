import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/data/pseudo_place_data.dart';
import 'package:prototype2021/loader/google_place_loader.dart';
import 'package:prototype2021/model/map/plan_map_model.dart';

void main() {
  group("PlanMapModel:", testPlanMapModel);
}

void testPlanMapModel() {
  List<PlaceDataProps> data = [
    PseudoPlaceData(
        location: LatLng(0, 0),
        name: "A",
        types: PlaceType.DEFAULT,
        address: null),
    PseudoPlaceData(
        location: LatLng(0, 3),
        name: "B",
        types: PlaceType.DEFAULT,
        address: null),
    PseudoPlaceData(
        location: LatLng(0, 2),
        name: "C",
        types: PlaceType.DEFAULT,
        address: null),
    PseudoPlaceData(
        location: LatLng(3, 0),
        name: "D",
        types: PlaceType.DEFAULT,
        address: null)
  ];

  test('update polyline', () async {
    final model = PlanMapModel(LatLng(0, 0));
    await model.markerList.loadImage();
    // polyline is null at the initial point
    expect(model.polyline, null);
    model.updatePolyline([]);
    expect(model.polyline, null);

    // polyline is null if data is only one
    model.updatePolyline([data[0]]);
    expect(model.polyline, null);
    expect(1, model.locations.length);

    // expect same length between data and points of polyline if data is newly added
    model.updatePolyline(data);
    expect(model.polyline != null, true);
    expect(model.polyline!.points.length, data.length);

    model.updatePolyline([]);
    expect(model.polyline, null);
  });
}
