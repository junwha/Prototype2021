import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';

/*
* This Class is parent location class of Event, Content, etc.
*/
class Location {
  final LatLng latLng;
  final String type;
  final String name;

  const Location(this.latLng, this.type, this.name);
}
