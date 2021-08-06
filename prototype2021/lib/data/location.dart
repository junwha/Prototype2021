import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/event_place_loader.dart';
import 'package:prototype2021/model/map/google_place_loader.dart';
import 'package:prototype2021/model/map/place_data.dart';
import 'package:prototype2021/settings/constants.dart';

/*
* This Class is parent location class of Event, Content, etc.
*/
class Location {
  final LatLng latLng;
  final String type;
  final String name;

  const Location(this.latLng, this.type, this.name);
}

class GooglePlaceLocation extends Location {
  late final String placeId;
  String? description;
  late String preview;

  GooglePlaceLocation(this.placeId, String? preview, String name,
      this.description, latLng, String type)
      : super(latLng, type, name) {
    this.preview = preview ?? placeHolder;
  }

  GooglePlaceLocation.fromData(GooglePlaceData placeData)
      : super(placeData.location, placeData.type, placeData.name) {
    this.placeId = placeData.placeId;
    this.preview = placeData.photo ?? placeHolder;
    this.description = placeData.address;
  }
}

class EventLocation extends Location {
  final EventPlaceData data;
  EventLocation.fromData(this.data)
      : super(data.latLng, PlaceType.EVENT, data.name);
}

class MultiEventLocation extends Location {
  List<EventPlaceData> eventPlaceList;
  MultiEventLocation(LatLng latLng, this.eventPlaceList)
      : super(
            latLng,
            PlaceType.EVENT,
            eventPlaceList.length > 0
                ? eventPlaceList[0].name
                : Random()
                    .nextInt(100000)
                    .toString()); // TODO: specify maximum number of markers
}