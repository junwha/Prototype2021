import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/content_location.dart';
import "package:prototype2021/model/location.dart";

class LocationModel with ChangeNotifier {
  List<dynamic> locations = [
    //TODO(junwha): check polymorphism!
    ContentLocation(0, "A", LatLng(35.5735, 129.1896))
  ];

  List<dynamic> get location => locations;

  /*
  * Update locations field with the locations included in boundary of bounds.
  */
  void updateLocations(LatLngBounds bounds) {
    //TODO(junwha): call this method when map changed action detected.
    //bounds.southwest; bounds.northeast;

    if (isUpdate(bounds)) {
      notifyListeners();
    } else {}
  }

  bool isUpdate(LatLngBounds bounds) {
    return false;
  }
}