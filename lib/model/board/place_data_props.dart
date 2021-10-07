/* 
 * 차후 API에서 오는 데이터에 맞게 이 추상 클래스를 바꿔서 이용해주세요!
 * 현재는 PseudoPlaceData가 이 추상 클래스를 implement하고 있습니다
*/
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/loader/google_place/google_place_loader.dart';
import 'package:prototype2021/model/board/contents/content_detail.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';

abstract class PlaceDataInterface {
  LatLng location;
  String name;
  double? rating;
  String types;
  ContentType contentType;
  String? photo;
  int id;
  String? address;
  String memo; // Just For Memo

  PlaceDataInterface({
    required this.location,
    required this.name,
    required this.types,
    required this.contentType,
    required this.id,
    required this.memo,
    this.rating,
    this.photo,
    this.address,
  });
}

class PlaceDataProps extends PlaceDataInterface {
  PlaceDataProps({
    required LatLng location,
    required String name,
    required int id,
    ContentType contentType = ContentType.unknown,
    double? rating,
    String? photo,
    String? address,
  }) : super(
          types: PlaceType.DEFAULT,
          memo: "",
          contentType: contentType,
          location: location,
          name: name,
          id: id,
          rating: rating,
          photo: photo,
          address: address,
        );

  PlaceDataProps.fromContentsDetail({required ContentsDetail source})
      : super(
          types: PlaceType.DEFAULT,
          memo: "",
          contentType: source.typeId,
          location: LatLng(0, 0), // Temporal set
          name: source.title,
          id: source.id,
          rating: source.rating,
          photo: source.thumbnail,
          address: source.address,
        );
}

class MemoData implements PlaceDataInterface {
  late LatLng location;
  late String name;
  late double? rating;
  late String types;
  ContentType contentType;
  late String? photo;
  late int id;
  late String? address;
  String memo; // Just For Memo

  MemoData({
    required this.memo,
  }) : contentType = ContentType.memo {
    name = "";
    types = "memo";
    id = -1;
    location = LatLng(0, 0);
  }
}

abstract class PlanDataProps {
  abstract String title;
  abstract String region;
  abstract DateTimeRange period;
  abstract String budget;
  abstract bool isHearted;
  abstract List<String> tags;
  abstract List<List<PlaceDataInterface>> planItemList;
}

class PseudoPlanData implements PlanDataProps {
  String title;
  String region;
  DateTimeRange period;
  String budget;
  bool isHearted;
  List<String> tags;
  List<List<PlaceDataInterface>> planItemList;

  PseudoPlanData(this.title, this.region, this.period, this.budget,
      this.isHearted, this.tags, this.planItemList);
}
