import 'package:flutter/material.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';

mixin ScheduleCardHelpers {
  Color placeColorByType(ContentType type) {
    switch (type) {
      case ContentType.spot:
      case ContentType.cultureInfra:
      case ContentType.events:
      case ContentType.leisureSports:
      case ContentType.shopping:
        return const Color(0xff4080ff);
      case ContentType.restaurants:
        return const Color(0xffff6e00);
      case ContentType.accomodations:
        return const Color(0xff6be6a7);
      default:
        return const Color(0xffaaaaaa);
    }
  }

  Image placeIconByType(ContentType type) {
    switch (type) {
      case ContentType.spot:
      case ContentType.cultureInfra:
      case ContentType.events:
      case ContentType.leisureSports:
      case ContentType.shopping:
        return Image.asset('assets/icons/ic_calender_destination.png');
      case ContentType.restaurants:
        return Image.asset('assets/icons/ic_calender_food.png');
      case ContentType.accomodations:
        return Image.asset('assets/icons/ic_calender_room.png');
      case ContentType.memo:
        return Image.asset('assets/icons/ic_calender_memo_white.png');
      default:
        return Image.asset('assets/icons/ic_calender_destination.png');
    }
  }
}
