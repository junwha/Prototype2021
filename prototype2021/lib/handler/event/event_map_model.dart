import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/loader/event/event_place_loader.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/utils/google_map/model/tb_map_model.dart';

class EventMapModel extends TBMapModel {
  EventPlaceLoader placeLoader = EventPlaceLoader();

  EventMapModel({required LatLng center}) : super(center) {
    findPlaces();
  }

  void findPlaces() async {
    List<Location> locations = await placeLoader.searchEventLocations(center);
    updateLocations(locations);
    notifyListeners();
  }
}