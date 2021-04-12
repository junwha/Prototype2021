import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/content_location.dart';
import 'package:flutter/material.dart';

class MarkerList {
  //TODO(junwha): generalize with CID and EID
  //Fields for Markers
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  int _markerIdCounter = 1;

  Set<Marker> get markerList => Set<Marker>.of(markers.values);

  MarkerList(List<dynamic> locationList) {
    //TODO(junwha): check polymorphism!
    for (ContentLocation location in locationList) {
      addMarker(location.latLng);
    }
  }

  //Add New Marker
  void addMarker(LatLng latLng) {
    final int markerCount = markers.length;

    //Set maximum of marker
    if (markerCount == 12) {
      return;
    }

    //marker ID
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

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
    );

    markers[markerId] = marker;
  }

  void removeMarker(LatLng latLng) {}
}
