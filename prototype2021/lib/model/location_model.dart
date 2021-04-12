import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import "package:prototype2021/model/location.dart";

class LocationModel with ChangeNotifier {
  final List<Location> locations = [];

  /*
  * Update locations field with the locations included in boundary of bounds.
  */
  void updateLocations(LatLngBounds bounds) {
    //bounds.southwest; bounds.northeast;
    if (isUpdate(bounds)) {
      notifyListeners();
    } else {}
  }

  bool isUpdate(LatLngBounds bounds) {
    return false;
  }
}
