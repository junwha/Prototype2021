import 'package:google_maps_flutter/google_maps_flutter.dart';

/*
* This Class is parent location class of Event, Content, etc.
*/
class Location {
  final LatLng latLng;

  const Location(this.latLng);
}

class GoogleLocation extends Location {
  final int cid;
  final String name;
  final String type;

  const GoogleLocation(this.cid, this.name, LatLng latLng, this.type)
      : super(latLng);
}
