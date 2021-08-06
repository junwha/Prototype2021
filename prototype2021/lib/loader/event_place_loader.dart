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
        "http://api.tripbuilder.co.kr/recruitments/events/near/?lat=${pos.latitude.toString().substring(0, 7)}&long=${pos.longitude.toString().substring(0, 7)}&radius=$radius");
    try {
      for (Map<String, dynamic> eventData in response) {
        locations.add(EventLocation.fromData(EventPlaceData(
            eventData["id"],
            eventData["name"],
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
    }
    return locations;
  }
}

class EventPlaceData {
  final DateTimeRange period;
  final int id;
  final int hearts;
  final int comments;
  final LatLng latLng;
  final String name;
  const EventPlaceData(
      this.id, this.name, this.hearts, this.comments, this.latLng, this.period);
}
