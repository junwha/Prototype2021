import 'package:geodesy/geodesy.dart' as Geodesy;
import 'package:google_maps_flutter/google_maps_flutter.dart';

/*
 * This is the class converting Google LatLng into Geodesy LatLng using adapter pattern
 * [Reference]: https://en.wikipedia.org/wiki/Adapter_pattern
 */
class GoogleGeodesyLatLngAdapter extends Geodesy.LatLng {
  GoogleGeodesyLatLngAdapter(LatLng latLng)
      : super(latLng.latitude, latLng.longitude);
}
