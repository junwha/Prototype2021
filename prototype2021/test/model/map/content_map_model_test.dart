import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:prototype2021/data/place_data.dart';
import 'package:prototype2021/loader/google_place/google_place_loader.dart';
import 'package:prototype2021/handler/google_place/content_map_model.dart';

import 'content_map_model_test.mocks.dart';

@GenerateMocks([PlaceLoader])
void main() {
  group("ContentMapModel:", testContentMapModel);
}

void testContentMapModel() {
  final loader = MockPlaceLoader();

  test('initial include types are false', () {
    final model = ContentMapModel(center: LatLng(0, 0));
    for (MapEntry<String, bool> entry in model.isIncludeType.entries) {
      // Key: Type (String), Value: Whether type is included (bool)
      expect(entry.value, false);
    }
  });

  test('findPlace', () {
    // TODO: Implement after Tour API completed
  });

  test('loadPlaces', () {
    // TODO: Implement after Tour API completed
  });

  test('move to result', () async {
    final model = ContentMapModel(center: LatLng(0, 0));
    await model.markerList.loadImage();

    Map<String, dynamic> googleExampleMeta = {
      "address_components": [
        {
          "long_name": "산188-7",
          "short_name": "산188-7",
          "types": ["premise"]
        },
        {
          "long_name": "조동리",
          "short_name": "조동리",
          "types": ["political", "sublocality", "sublocality_level_3"]
        },
        {
          "long_name": "동량면",
          "short_name": "동량면",
          "types": ["political", "sublocality", "sublocality_level_2"]
        },
        {
          "long_name": "충주시",
          "short_name": "충주시",
          "types": ["locality", "political"]
        },
        {
          "long_name": "충청북도",
          "short_name": "충청북도",
          "types": ["administrative_area_level_1", "political"]
        },
        {
          "long_name": "대한민국",
          "short_name": "KR",
          "types": ["country", "political"]
        },
        {
          "long_name": "380-814",
          "short_name": "380-814",
          "types": ["postal_code"]
        }
      ],
      "formatted_address": "대한민국 충청북도 충주시 동량면 조동리 산188-7",
      "geometry": {
        "location": {"lat": 37.0005127, "lng": 127.9995023},
        "location_type": "ROOFTOP",
        "viewport": {
          "northeast": {"lat": 37.0018616802915, "lng": 128.0008512802915},
          "southwest": {"lat": 36.9991637197085, "lng": 127.9981533197085}
        }
      },
      "place_id": "ChIJZRxxswx-ZDURAm_wkKaUnwA",
      "plus_code": {
        "compound_code": "2X2X+6R 대한민국 충청북도 충주시",
        "global_code": "8Q992X2X+6R"
      },
      "types": ["street_address"]
    };
    model.moveToResult(GooglePlaceData(googleExampleMeta, PlaceType.DEFAULT));
    expect(model.locations.length, 1);
    expect(model.center.latitude.toStringAsFixed(6),
        googleExampleMeta["geometry"]["location"]["lat"].toStringAsFixed(6));
    expect(model.center.longitude.toStringAsFixed(6),
        googleExampleMeta["geometry"]["location"]["lng"].toStringAsFixed(6));
    for (MapEntry<String, bool> entry in model.isIncludeType.entries) {
      // Key: Type (String), Value: Whether type is included (bool)
      expect(entry.value, false);
    }
  });
}
