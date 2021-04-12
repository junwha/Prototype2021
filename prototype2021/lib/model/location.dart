import 'package:google_maps_flutter/google_maps_flutter.dart';

/*
* This Class is parent location class of Event, Content, etc.
*/
abstract class Location {
  LatLng latLng;

  Location(this.latLng);
}
