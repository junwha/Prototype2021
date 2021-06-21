import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/map_place.dart';
import 'package:prototype2021/model/location.dart';
import 'package:flutter/material.dart';

class MarkerList {
  //TODO(junwha): generalize with CID and EID

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; //Fields for Markers
  MarkerId? selectedMarker;
  int _markerIdCounter = 1;
  Marker? focusedMarker;
  Function? onFocusChanged;

  Map<String, BitmapDescriptor> markerIconMap =
      {}; // Math marker Icon with Types

  double bearing = 0; //Rotation

  Set<Marker> get markerList => Set<Marker>.of(markers.values);

  MarkerList({this.onFocusChanged});
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
      markerIconMap['E'] = await MarkerImage.createIcon(
          'assets/images/map/event_marker.png', 100);

      return true;
    } catch (e) {
      return false;
    }
  }

  /*
  * Add markers on the locations in location list
  */
  void addMarkerList(List<Location> locationList) {
    // print(markerIcon);
    for (Location location in locationList) {
      if (location is ContentLocation) {
        addMarker(location.latLng, location.type, location.name);
      }
    }
  }

  /*
  * Add new marker on the location
  */
  void addMarker(LatLng latLng, String type, String name) {
    final int markerCount = markers.length;

    //Set maximum of marker
    // if (markerCount == 12) {
    //   return;
    // }

    final MarkerId markerId = MarkerId(name);
    //marker ID
    // final String markerIdVal = 'marker_id_$_markerIdCounter';
    // _markerIdCounter++;
    // final MarkerId markerId = MarkerId(markerIdVal);

    BitmapDescriptor markerIcon = markerIconMap[PlaceType.DEFAULT]!;
    if (markerIconMap.containsKey(type)) {
      markerIcon = markerIconMap[type]!;
    }
    //Create Marker
    final Marker marker = Marker(
      markerId: markerId,
      position: latLng,
      infoWindow: InfoWindow(title: name),
      onTap: () {
        changeFocus(markerId);
        print("Marker tapped!!!!!!");
        //_onMarkerTapped(markerId);
      },
      flat: true,
      icon: markerIcon,
      anchor: Offset(0.5, 0.5),
      rotation: bearing,
    );

    markers[markerId] = marker;
  }

  void removeMarker(int id) {}

  void removeAll() {
    markers = <MarkerId, Marker>{};
  }

  /*
  * Change focus with markerId
  */
  void changeFocus(MarkerId markerId) {
    this.focusedMarker = markers[markerId];
    onFocusChanged?.call();
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
