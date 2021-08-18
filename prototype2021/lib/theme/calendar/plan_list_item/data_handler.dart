import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/theme/calendar/plan_list_item.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/middle_divider.dart';
import 'package:prototype2021/theme/calendar/schedule_card.dart';

mixin PlanListItemDataHandlerMixin on State<PlanListItem> {
  final Geodesy _geodesy = new Geodesy();

  int toWidgetIndex(int index) => (index + 2) ~/ 2;

  List<Widget> placeDataToWidgets(List<PlaceDataProps> data, int dateIndex,
      void Function() Function(int) deleteSelfFactory) {
    /* 
     * This returns a list of widgets from a list of placeData, num, and null
     * which appear in the list in turn. For example:
     * [null, plaeData1, distanceBetween1N2, placeData2, ..., placeDataN, null]
     * null will be rendered as placeholder, placeData as schedule card, 
     * num as distance icon which indicates distance between 
     * former place and latter place
    */
    return data
        .fold<List<dynamic>>([], (acc, cur) {
          int dataIdx = acc.length ~/ 2;
          num? distanceBetweenCurAndNext;
          for (var i = dataIdx + 1; i < data.length; i++) {
            PlaceDataProps nextData = data[i];
            if (nextData.types != "memo") {
              distanceBetweenCurAndNext = _geodesy.distanceBetweenTwoGeoPoints(
                  cur.location, nextData.location);
              break;
            }
          }
          acc.addAll(
              [cur, cur.types == "memo" ? null : distanceBetweenCurAndNext]);
          return acc;
        })
        .asMap()
        .map((index, placeDataOrDistance) => MapEntry(
            index,
            Container(
                key: ValueKey("$dateIndex-$index"),
                child: placeDataOrDistance is PlaceDataProps
                    ? ScheduleCard(
                        data: placeDataOrDistance,
                        order: toWidgetIndex(index),
                        dateIndex: dateIndex,
                        deleteSelf: deleteSelfFactory(toWidgetIndex(index)),
                      )
                    : PlanListMiddleDivider(distance: placeDataOrDistance))))
        .values
        .toList();
  }
}
