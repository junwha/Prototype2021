import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/map/google_place_loader.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/model/safe_http.dart';

class EventPlaceLoader {
  Future<List<EventLocation>> searchEventLocations(LatLng pos,
      {int radius = 500}) async {
    List<EventLocation> locations = [];
    dynamic response = await safeGET(
        "http://api.tripbuilder.co.kr/recruitments/events/near/?lat=${pos.latitude}&long=${pos.longitude}&radius=$radius");
    try {
      for (Map<String, dynamic> eventData in response) {
        // locations.add(EventLocation(
        //     eventData["name"],
        //     eventData["hearts"],
        //     eventData["comments"],
        //     // LatLng(
        //     //   double.parse(eventData["coord"]["lat"]),
        //     //   double.parse(eventData["coord"]["long"]),
        //     // ),
        //     LatLng(35.5735, 129.1896),
        //     PlaceType.EVENT,
        //     DateTimeRange(
        //       start: DateTime.parse(eventData["period"]["start"]),
        //       end: DateTime.parse(eventData["period"]["end"]),
        //     )));
      }
    } catch (e) {
      print("Unexpected Error");
    }
    return locations;
  }
}
