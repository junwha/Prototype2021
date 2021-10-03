import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/data/location.dart';
import 'package:prototype2021/loader/google_place/google_place_loader.dart';
import 'package:prototype2021/utils/google_map/widgets/marker.dart';

// class PlanMarkerType
class PlanMarker extends MarkerList {
  Map<String, List<BitmapDescriptor>> planMarkerIconMap = {};

  @override
  Future<bool> loadImage() async {
    Map<String, String> placeTypeToFileName = {
      PlaceType.CAFE: "cafe",
      PlaceType.SPOT: "destination",
      PlaceType.RESTAURANT: "restaurant",
      PlaceType.HOTEL: "room"
    };
    bool isSuperComplete = await super.loadImage();
    try {
      // Load 1~9 and 9+ images corresponding to the types
      for (MapEntry<String, String> entry in placeTypeToFileName.entries) {
        planMarkerIconMap[entry.key] = [];
        for (int i = 1; i <= 9; i++) {
          planMarkerIconMap[entry.key]!.add(await MarkerImage.createIcon(
              'assets/icons/pin_big_${entry.value}_$i.png', 100));
        }
        planMarkerIconMap[entry.key]!.add(await MarkerImage.createIcon(
            'assets/icons/pin_big_${entry.value}_9plus.png', 100));
      }

      return true && isSuperComplete;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void addMarkers(Iterable<Location> locationList) {
    for (Location location in locationList) {
      if (location is IndexLocation) {
        try {
          addMarker(location,
              externalMarkerIcon:
                  planMarkerIconMap[location.type]![location.index]);
        } catch (e) {
          addMarker(location);
        }
      } else {
        addMarker(location);
      }
    }
  }
}
