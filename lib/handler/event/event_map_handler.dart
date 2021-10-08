import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/loader/event/event_place_loader.dart';
import 'package:prototype2021/utils/google_map/handler/location.dart';
import 'package:prototype2021/utils/google_map/handler/tb_map_handler.dart';

class EventMapHandler extends TBMapHandler {
  EventPlaceLoader placeLoader = EventPlaceLoader();

  EventMapHandler({required LatLng center}) : super(center) {
    findPlaces();
  }

  void findPlaces() async {
    List<Location> locations = await placeLoader.searchEventLocations(center);
    updateLocations(locations);
    notifyListeners();
  }
}
