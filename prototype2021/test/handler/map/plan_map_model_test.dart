import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/model/board/place_data_props.dart';
import 'package:prototype2021/model/board/pseudo_place_data.dart';
import 'package:prototype2021/loader/google_place/google_place_loader.dart';
import 'package:prototype2021/handler/board/plan/plan_map_handler.dart';

void main() {
  group("PlanMapModel:", testPlanMapModel);
}

void testPlanMapModel() {
  List<PlaceDataProps> data = [
    PseudoPlaceData(
        location: LatLng(0, 0),
        name: "cafe",
        types: PlaceType.CAFE,
        address: null),
    PseudoPlaceData(
        location: LatLng(0, 3),
        name: "spot",
        types: PlaceType.SPOT,
        address: null),
    PseudoPlaceData(
        location: LatLng(0, 2),
        name: "restaurant",
        types: PlaceType.RESTAURANT,
        address: null),
    PseudoPlaceData(
        location: LatLng(3, 0),
        name: "hotel",
        types: PlaceType.HOTEL,
        address: null)
  ];

  test('update polyline', () async {
    final model = PlanMapHandler(LatLng(0, 0));
    await model.markerList.loadImage();
    // polyline is null at the initial point
    expect(model.polyline, null);
    model.updatePlaceData([]);
    expect(model.polyline, null);

    // Update polyline with one event location
    model.updatePlaceData([
      [
        PseudoPlaceData(
            location: LatLng(3, 0),
            name: "nontype",
            types: PlaceType.EVENT,
            address: null)
      ]
    ]);
    // polyline is null if data is only one
    expect(1, model.locations.length);
    model.setDay(2);
    // out of range is not applied
    expect(1, model.locations.length);
    // there is no polyline if marker is only one
    expect(model.polyline, null);

    // expect same length between data and points of polyline if data is newly added
    model.updatePlaceData([data]);
    expect(model.polyline != null, true);
    expect(model.polyline!.points.length, data.length);

    // All data have to be saved as IndexLocation
    expect(
        model.locations.map((e) => e is IndexLocation).contains(false), false);

    model.updatePlaceData([]);
    expect(model.locations.length, 0);
    expect(model.polyline, null);
  });

  test('day selection', () async {
    final model = PlanMapHandler(LatLng(0, 0));
    await model.markerList.loadImage();

    model.updatePlaceData([
      [
        PseudoPlaceData(
            location: LatLng(3, 0),
            name: "nontype",
            types: PlaceType.EVENT,
            address: null)
      ],
      data,
      []
    ]);

    // initial day is 1
    expect(model.day, 1);
    expect(model.locations.length, 1);
    expect(model.polyline, null);

    // day selection is works well
    model.setDay(2);
    expect(model.day, 2);
    expect(model.locations.length, data.length);
    expect(model.polyline!.points.length, data.length);

    model.setDay(3);
    expect(model.day, 3);
    expect(model.locations.length, 0);
    expect(model.polyline, null);
  });
}
