import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/ui/location.dart';

class ContentLocation extends Location {
  final int cid;
  final String name;
  final String type;

  const ContentLocation(this.cid, this.name, LatLng latLng, this.type)
      : super(latLng);
}
