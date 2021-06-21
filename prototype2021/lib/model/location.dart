import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    this.preview = preview ??
        "https://image.shutterstock.com/image-vector/ui-image-placeholder-wireframes-apps-260nw-1037719204.jpg";
  }
}

class EventLocation extends Location {
  final DateTimeRange period;
  const EventLocation(String name, LatLng latLng, String type, this.period)
      : super(latLng, type, name);
}
