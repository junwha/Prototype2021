import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/loader/google_place_loader.dart';
import 'package:prototype2021/data/location.dart';
import 'package:flutter/material.dart';

class MarkerList {
  //TODO(junwha): generalize with CID and EID

  Map<Location, Marker> markers = <Location, Marker>{}; //Fields for Markers
  Location? focusedLocation;

  Map<String, BitmapDescriptor> markerIconMap =
      {}; // Math marker Icon with Types

  double bearing = 0; //Rotation

  Set<Marker> get markerList => Set<Marker>.of(markers.values);

  MarkerList();

  /*
  * Initialize marker image. if image loaded completely, call notifyListeners
  */
  Future<bool> loadImage() async {
    try {
      markerIconMap[PlaceType.DEFAULT] =
          await MarkerImage.createIcon('assets/images/map/marker.png', 100);
      markerIconMap[PlaceType.CAFFEE] = await MarkerImage.createIcon(
          'assets/images/map/caffee_marker.png', 100);
      markerIconMap[PlaceType.RESTAURANT] = await MarkerImage.createIcon(
          'assets/images/map/restaurant_marker.png', 100);
      markerIconMap[PlaceType.EVENT] = await MarkerImage.createIcon(
          'assets/images/map/event_marker.png', 100);

      return true;
    } catch (e) {
      return false;
    }
  }

  /*
  * Add markers on the locations in location list
  */
  void addMarkers(Iterable<Location> locationList) {
    print("Draw marker start");
    // print(markerIcon);
    for (Location location in locationList) {
      if (location is GooglePlaceLocation) {
        addMarker(location);
      } else {
        addMarker(location);
      }
    }
    print("Draw marker end");
  }

  /*
  * Add new marker on the location
  */
  void addMarker(Location location, {bool clickable = true}) {
    final int markerCount = markers.length;

    //Set maximum of marker
    // if (markerCount == 12) {
    //   return;
    // }

    final MarkerId markerId = MarkerId(location.name);
    //marker ID
    // final String markerIdVal = 'marker_id_$_markerIdCounter';
    // _markerIdCounter++;
    // final MarkerId markerId = MarkerId(markerIdVal);

    BitmapDescriptor markerIcon = markerIconMap[PlaceType.DEFAULT]!;
    if (markerIconMap.containsKey(location.type)) {
      markerIcon = markerIconMap[location.type]!;
    }
    //Create Marker
    final Marker marker = Marker(
      markerId: markerId,
      position: location.latLng,
      onTap: () {
        if (clickable) {
          changeFocus(location);
        }
      },
      flat: true,
      icon: markerIcon,
      anchor: Offset(0.5, 0.5),
      rotation: bearing,
    );

    markers[location] = marker;
  }

  void removeMarker(Location location) {
    markers.remove(location);
  }

  void removeMarkers(Iterable<Location> locations) {
    for (Location location in locations) {
      removeMarker(location);
    }
  }

  void removeAll() {
    markers = <Location, Marker>{};
  }

  /*
  * Change focus with Location
  */
  void changeFocus(Location? location) {
    if (location != null) {
      this.focusedLocation = location;
      print(location.latLng);
    } else {
      this.focusedLocation = null;
    }
  }
}

class MarkerImage {
  /*
  * Return marker icon from asset path
  */
  static Future<BitmapDescriptor> createIcon(String path, int size) async {
    Uint8List bytes = await getBytesFromAsset(path, size);
    return BitmapDescriptor.fromBytes(bytes);
  }

  /*
  * Converts Image to byte data
  */
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
