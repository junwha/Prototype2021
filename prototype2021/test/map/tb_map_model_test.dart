import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/data/location.dart';
import 'package:prototype2021/loader/google_place_loader.dart';
import 'package:prototype2021/model/map/tb_map_model.dart';

void main() {
  group("TBMapModel:", testTBMapModel);
}

void testTBMapModel() {
  Location A = Location(LatLng(0, 0), PlaceType.EVENT, "A");
  final List<Location> locationsAC = [
    A,
    Location(LatLng(0, 1), PlaceType.EVENT, "B"),
    Location(LatLng(0, 2), PlaceType.EVENT, "C"),
  ];

  final List<Location> locationsAD = [
    A,
    Location(LatLng(0, 3), PlaceType.EVENT, "D"),
  ];

  final List<Location> locationsE = [
    Location(LatLng(0, 4), PlaceType.EVENT, "E")
  ];

  test('change center', () {
    final model = TBMapModel(LatLng(0, 0));

    model.updateCenter(LatLng(1, 1));
    expect(LatLng(1, 1), model.center);
  });

  test('add locations', () async {
    final model = TBMapModel(LatLng(0, 0));
    await model.markerList.loadImage();

    expect(model.locations.length, 0);
    model.addLocations(locationsAC);
    expect(model.locations.length, 3);
    model.addLocations(locationsAD);
    expect(model.locations.length, 4);
  });

  test('update locations', () async {
    final model = TBMapModel(LatLng(0, 0));
    await model.markerList.loadImage();

    expect(model.locations.length, 0);
    model.updateLocations(locationsAC);
    expect(model.locations.length, 3);
    model.updateLocations(locationsAD);
    expect(model.locations.length, 2);
  });

  test('remove locations', () async {
    final model = TBMapModel(LatLng(0, 0));
    await model.markerList.loadImage();

    model.addLocations(locationsAC);
    expect(model.locations.length, 3);
    model.removeLocations(locationsAC);
    expect(model.locations.length, 0);
    model.addLocations(locationsAC);
    expect(model.locations.length, 3);
    model.removeLocations(locationsE);
    expect(model.locations.length, 3);
    model.removeLocations(locationsAD);
    expect(model.locations.length, 2);
  });
}
