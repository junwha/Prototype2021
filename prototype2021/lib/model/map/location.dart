import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/settings/constants.dart';

/*
* This Class is parent location class of Event, Content, etc.
*/
class Location {
  final LatLng latLng;
  final String type;
  final String name;

  const Location(this.latLng, this.type, this.name);
}

class GoogleLocation extends Location {
  final int cid;
  late String preview;
  GoogleLocation(
      this.cid, String? preview, String name, LatLng latLng, String type)
      : super(latLng, type, name) {
    this.preview = preview ?? placeHolder;
  }
}

class EventLocation extends Location {
  final DateTimeRange period;
  const EventLocation(String name, LatLng latLng, String type, this.period)
      : super(latLng, type, name);
}
