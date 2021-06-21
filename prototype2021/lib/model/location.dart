import 'package:google_maps_flutter/google_maps_flutter.dart';

/*
* This Class is parent location class of Event, Content, etc.
*/
class Location {
  final LatLng latLng;

  const Location(this.latLng);
}

class ContentLocation extends Location {
  final int cid;
  final String name;
  final String type;

  const ContentLocation(this.cid, this.name, LatLng latLng, this.type)
      : super(latLng);
}
