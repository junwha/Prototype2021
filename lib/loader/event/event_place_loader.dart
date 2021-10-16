import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/google_place/place_data.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/utils/google_map/handler/location.dart';
import 'package:prototype2021/utils/safe_http/legacy_http.dart';
import 'package:prototype2021/settings/constants.dart';

class EventPlaceLoader {
  Future<List<Location>> searchEventLocations(LatLng pos,
      {int radius = 500}) async {
    dynamic response = await legacyGET(
        "$apiBaseUrl/recruitments/events/near/?lat=${pos.latitude.toStringAsFixed(6)}&long=${pos.longitude.toStringAsFixed(6)}&radius=$radius");
    List<EventLocation> locations = [];
    try {
      for (Map<String, dynamic> eventData in response) {
        locations.add(EventLocation.fromData(EventPlaceData(
            eventData["id"],
            eventData["title"],
            eventData["hearts"],
            eventData["comments"],
            LatLng(
              double.parse(eventData["coord"]["lat"]),
              double.parse(eventData["coord"]["long"]),
            ),
            DateTimeRange(
              start: DateTime.parse(eventData["period"]["start"]),
              end: DateTime.parse(eventData["period"]["end"]),
            ))));
      }
    } catch (e) {
      print("Unexpected Error");
      print(e);
    }
    return locations;
  }
}
