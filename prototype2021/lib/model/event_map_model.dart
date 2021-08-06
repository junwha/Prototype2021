import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/loader/event_place_loader.dart';
import 'package:prototype2021/data/location.dart';
import 'package:prototype2021/model/map/tb_map_model.dart';

class EventMapModel extends TBMapModel {
  EventPlaceLoader placeLoader = EventPlaceLoader();

  EventMapModel({required LatLng center}) : super(center) {
    findPlaces();
  }

  void findPlaces() async {
    List<EventLocation> locations =
        await placeLoader.searchEventLocations(center);
    updateLocations(locations);
    print(markerList.markers.length);
    notifyListeners();
  }
}
