import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/ui/marker_list.dart';
import 'package:prototype2021/ui/location.dart';
import 'package:prototype2021/ui/content_location.dart';

class LocationModel with ChangeNotifier {
  List<Location> locations = [
    ContentLocation(0, "A", LatLng(35.5735, 129.1896))
  ];

  MarkerList markerList = MarkerList();

  LocationModel() {
    markerList.init(notifyListeners);
  }

  Set<Marker> markers() {
    markerList.addMarkerList(locations);
    ChangeNotifier();
    return markerList
        .markerList; //TODO: consider update location with efficiency
  }

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
