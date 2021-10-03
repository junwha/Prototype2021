import 'dart:math';
import 'package:prototype2021/model/board/place_data_props.dart';
import 'package:prototype2021/model/board/pseudo_place_data.dart';

mixin PlanListItemHelper {
  PlaceDataProps randomPlaceData() {
    return pseudoPlaceData[Random().nextInt(pseudoPlaceData.length)];
  }

  String distanceWithUnit(num distance) {
    if (distance < 1000) {
      return "${distance.toStringAsFixed(0)}m";
    } else {
      String distanceInKm = (distance / 1000).toStringAsFixed(1);
      return "${distanceInKm}km";
    }
  }
}
