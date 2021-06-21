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

  const GoogleLocation(this.cid, String name, LatLng latLng, String type)
      : super(latLng, type, name);
}

// class EventLocation extends Location {
//   final Stirng name;
//   const EventLocation()
// }
