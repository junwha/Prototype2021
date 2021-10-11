import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/loader/google_place/google_place_loader.dart';
import 'package:prototype2021/model/google_place/place_data.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/utils/google_map/handler/location.dart';

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

/*
 * This location type is the index specified location type.
 * Generally, use this with plan map
 */
class IndexLocation extends Location {
  late int index;
  IndexLocation(int index, LatLng latLng, String type, String name,
      {int maxIndex = 8})
      : super(latLng, type, name) {
    this.index = (index <= maxIndex)
        ? index
        : maxIndex +
            1; // if index is over maxIndex, set index as maxIndex+1 (this logic is for marker index of 9+)
  }
}
