import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/loader/google_place_loader.dart';
import 'package:prototype2021/model/map/content_map_model.dart';

void main() {
  group("ContentMapModel:", testContentMapModel);
}

void testContentMapModel() {
  test('include type is false', () {
    final model = ContentMapModel(center: LatLng(0, 0));
    for (MapEntry<String, bool> entry in model.isIncludeType.entries) {
      expect(entry.value, false);
    }
  });
}
