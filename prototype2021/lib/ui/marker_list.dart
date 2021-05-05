import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/map_place.dart';
import 'package:prototype2021/ui/content_location.dart';
import 'package:prototype2021/ui/location.dart';
import 'package:flutter/material.dart';

class MarkerList {
  //TODO(junwha): generalize with CID and EID
  //Fields for Markers
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  int _markerIdCounter = 1;
  Map<String, BitmapDescriptor> markerIconMap = {};

  double bearing = 0;

  Set<Marker> get markerList => Set<Marker>.of(markers.values);

  /*
  * Initialize marker image. if image loaded completely, call notifyListeners
  */
  Future<bool> loadImage() async {
    try {
      markerIconMap[DEFAULT] =
          await MarkerImage.createIcon('assets/images/map/marker.png', 100);
      markerIconMap[CAFFEE] = await MarkerImage.createIcon(
          'assets/images/map/caffee_marker.png', 100);
      markerIconMap[RESTAURANT] = await MarkerImage.createIcon(
          'assets/images/map/restaurant_marker.png', 100);
      markerIconMap['E'] = await MarkerImage.createIcon(
          'assets/images/map/event_marker.png', 100);

      return true;
    } catch (e) {
      return false;
    }
  }

  /*
  * Converts Image to byte data
  */

  /*
  * Add markers on the locations in location list
  */
  void addMarkerList(List<Location> locationList) {
    // print(markerIcon);
    for (Location location in locationList) {
      if (location is ContentLocation) {
        addMarker(location.latLng, location.type);
      }
    }
  }

  /*
  * Add new marker on the location
  */
  void addMarker(LatLng latLng, String type) {
    final int markerCount = markers.length;

    //Set maximum of marker
    // if (markerCount == 12) {
    //   return;
    // }

    //marker ID
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    BitmapDescriptor markerIcon = markerIconMap[DEFAULT]!;
    if (markerIconMap.containsKey(type)) {
      markerIcon = markerIconMap[type]!;
    }
    //Create Marker
    final Marker marker = Marker(
      markerId: markerId,
      position: latLng,
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {
        //_onMarkerTapped(markerId);
      },
      onDragEnd: (LatLng position) {
        //_onMarkerDragEnd(markerId, position);
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
}

class MarkerImage {
  static Future<BitmapDescriptor> createIcon(String path, int size) async {
    Uint8List bytes = await getBytesFromAsset(path, size);
    return BitmapDescriptor.fromBytes(bytes);
  }

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
