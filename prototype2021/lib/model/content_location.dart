import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/location.dart';

class ContentLocation extends Location {
  final int cid;
  final String name;

  const ContentLocation(this.cid, this.name, LatLng latLng) : super(latLng);
}
