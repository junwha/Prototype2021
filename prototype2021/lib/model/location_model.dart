import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/map_place.dart';
import 'package:prototype2021/ui/marker.dart';
import 'package:prototype2021/model/location.dart';

class LocationModel with ChangeNotifier {
  List<Location> locations = [
    ContentLocation(0, "A", LatLng(37.5172, 127.0473), PlaceType.DEFAULT)
  ];

  MarkerList markerList = MarkerList();
  bool loaded = false;
  LatLng center;
  late PlaceLoader placeLoader;

  LocationModel({required this.center}) {
    init();
  }

  void init() async {
    loaded = await markerList.loadImage(); // Load Marker Icons
    this.placeLoader = PlaceLoader(center: this.center);
    List<String> types = [
      PlaceType.RESTAURANT,
      PlaceType.HOTEL,
      PlaceType.SPOT,
      PlaceType.CAFFEE
    ];
    await loadPlaces(types, 500);
  }

  Future<void> loadPlaces(List<String> types, int radius) async {
    this.placeLoader.changeCenter(this.center);

    List<PlaceData> placeDataList = await placeLoader.getPlaces([
      PlaceType.RESTAURANT,
      PlaceType.HOTEL,
      PlaceType.SPOT,
      PlaceType.CAFFEE
    ], radius: 100);

    // Find nearby places with specified types
    for (PlaceData placeData in placeDataList) {
      // Add all placeData to location list
      locations.add(ContentLocation(locations.length, placeData.name,
          placeData.location, placeData.type));
    }

    markerList.addMarkerList(locations); // Create markers
    notifyListeners();
  }

  void loadData() {}

  Set<Marker> get markers =>
      markerList.markerList; //TODO: consider update location with efficiency

  /*
  * Update locations field with the locations included in boundary of bounds.
  */

  void setBearing(double bearing) {
    if (markerList.bearing != bearing) {
      markerList.bearing = bearing;
      markerList.removeAll();
      markerList.addMarkerList(locations);
      notifyListeners();
    }
  }

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

  void updateMarkers() {}

  void findNearByPlaces() {}
}
