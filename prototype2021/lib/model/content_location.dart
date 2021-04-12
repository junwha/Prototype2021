import 'package:prototype2021/model/Location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContentLocation extends Location {
  int cid;
  String name;

  ContentLocation(this.cid, this.name, LatLng latLng) : super(latLng);
}
