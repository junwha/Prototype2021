import 'package:flutter/material.dart';

mixin ScheduleCardHelpers {
  Color placeColorByType(String type) {
    switch (type) {
      case "attraction":
        return const Color(0xff4080ff);
      case "cafe":
        return const Color(0xffff6e00);
      case "restaurant":
        return const Color(0xffff6e00);
      case "accomodations":
        return const Color(0xff6be6a7);
      default:
        return const Color(0xffaaaaaa);
    }
  }

  Image placeIconByType(String type) {
    switch (type) {
      case "attraction":
        return Image.asset('assets/icons/ic_calender_destination.png');
      case "cafe":
        return Image.asset('assets/icons/ic_calender_food.png');
      case "restaurant":
        return Image.asset('assets/icons/ic_calender_food.png');
      case "accomodations":
        return Image.asset('assets/icons/ic_calender_room.png');
      case "memo":
        return Image.asset('assets/icons/ic_calender_memo_white.png');
      default:
        return Image.asset('assets/icons/ic_calender_destination.png');
    }
  }
}
