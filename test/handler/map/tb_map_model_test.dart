import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/loader/google_place/google_place_loader.dart';
import 'package:prototype2021/utils/google_map/handler/location.dart';
import 'package:prototype2021/utils/google_map/handler/tb_map_handler.dart';

void main() {
  group("TBMapModel:", testTBMapModel);
}

void testTBMapModel() {
  Location A = Location(LatLng(0, 0), PlaceType.EVENT, "A");
  final List<Location> locationsABC = [
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
    final model = TBMapHandler(LatLng(0, 0));

    model.updateCenter(LatLng(1, 1));
    expect(LatLng(1, 1), model.center);
  });

  test('add locations', () async {
    final model = TBMapHandler(LatLng(0, 0));
    await model.markerList.loadImage();

    // initial length check
    expect(model.locations.length, 0);
    model.addLocations(locationsABC);
    // 3 are added
    expect(model.locations.length, 3);
    model.addLocations(locationsAD);
    // A of newer is same as A of old one.
    expect(model.locations.length, 4);
  });

  test('update locations', () async {
    final model = TBMapHandler(LatLng(0, 0));
    await model.markerList.loadImage();

    // initial length check
    expect(model.locations.length, 0);
    model.updateLocations(locationsABC);
    // 3 are added
    expect(model.locations.length, 3);
    model.updateLocations(locationsAD);
    // no matter what exists before, only A and D had to be added.
    expect(model.locations.length, 2);
  });

  test('remove locations', () async {
    final model = TBMapHandler(LatLng(0, 0));
    await model.markerList.loadImage();

    model.addLocations(locationsABC);
    // general remove
    expect(model.locations.length, 3);
    model.removeLocations(locationsABC);
    expect(model.locations.length, 0);

    // try to remove the locations which not exist
    model.addLocations(locationsABC);
    expect(model.locations.length, 3);
    model.removeLocations(locationsE);
    expect(model.locations.length, 3);

    // try to remove with heterogeneous list
    model.removeLocations(locationsAD);
    expect(model.locations.length, 2);
  });

  test('clear map', () async {
    final model = TBMapHandler(LatLng(0, 0));
    await model.markerList.loadImage();

    model.addLocations(locationsABC);
    expect(model.locations.length != 0, true);
    model.clearMap();
    expect(model.locations.length, 0);
  });

  test('update bearing', () async {
    final model = TBMapHandler(LatLng(0, 0));
    await model.markerList.loadImage();

    final initialBearing = model.markerList.bearing;

    model.updateBearing(23.2);
    expect(model.markerList.bearing != initialBearing, true);

    model.addLocations(locationsABC);
    model.updateBearing(35.0);
    expect(model.markerList.bearing, 35.0);
    // check if the rotations of markers are all changed
    for (Marker marker in model.markerList.markers.values) {
      expect(marker.rotation, 35.0);
    }
  });

  test('redraw map', () async {
    final model = TBMapHandler(LatLng(0, 0));
    await model.markerList.loadImage();

    model.addLocations(locationsABC);
    int initialLength = model.locations.length;

    model.redrawMap();
    expect(model.locations.length, initialLength);
  });

  test('focus', () async {
    final model = TBMapHandler(LatLng(0, 0));
    await model.markerList.loadImage();
    Location newLocation = Location(LatLng(0, 0), PlaceType.DEFAULT, "new");

    // inital focused location
    model.addLocations(locationsABC);
    expect(model.markerList.focusedLocation, null);
    expect(model.isFocused(), false);

    // new focused location
    model.changeFocus(A);
    expect(model.markerList.focusedLocation, A);
    expect(model.isFocused(), true);

    // if the location which is not exist has tried to be focus, maintain old one
    model.changeFocus(newLocation);
    expect(model.markerList.focusedLocation, A);
    expect(model.isFocused(), true);

    // change with newely added location
    model.addLocations([newLocation]);
    model.changeFocus(newLocation);
    expect(model.markerList.focusedLocation, newLocation);
    expect(model.isFocused(), true);

    model.removeFocus();
    expect(model.markerList.focusedLocation, null);
    expect(model.isFocused(), false);
  });
}
