import 'package:prototype2021/model/Location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContentLocation extends Location {
  final int cid;
  final String name;

  const ContentLocation(this.cid, this.name, LatLng latLng) : super(latLng);
}
