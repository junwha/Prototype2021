import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/data/pseudo_place_data.dart';
import 'package:prototype2021/model/calendar.dart';
import 'package:prototype2021/model/plan_make_calendar_model.dart';
import 'package:prototype2021/theme/calendar/plan_make_home.dart';
import 'package:prototype2021/theme/calendar/schedule_card.dart';
import 'package:provider/provider.dart';

const double PlanListItemPadding = 28;

class PlanListItem extends StatefulWidget {
  final PlanMakeMode mode;
  final int dateIndex;
  final void Function() incrementOpenedCount;
  final void Function() decrementOpenedCount;
  PlanListItem(
      {required this.dateIndex,
      required this.incrementOpenedCount,
      required this.decrementOpenedCount,
      required this.mode});

  @override
  _PlanListItemState createState() => _PlanListItemState(
      dateIndex: dateIndex,
      incrementOpenedCount: incrementOpenedCount,
      decrementOpenedCount: decrementOpenedCount,
      mode: mode);
}

class _PlanListItemState extends State<PlanListItem>
    with SingleTickerProviderStateMixin, PlaceListItemHelper {
  List<PlaceDataProps> data = [];
  final PlanMakeMode mode;
  final int dateIndex;
  final void Function() incrementOpenedCount;
  final void Function() decrementOpenedCount;

  bool _expanded = false;
  void _setExpanded(bool expanded) {
    if (expanded) {
      incrementOpenedCount();
      _expandController.forward();
    } else {
      decrementOpenedCount();
      _expandController.reverse();
    }
    setState(() {
      _expanded = expanded;
    });
  }

  void _toggleExpanded() {
    _setExpanded(!_expanded);
  }

  String _memo = "";
  void _setMemo(String memo) {
    setState(() {
      _memo = memo;
    });
  }

  void _createMemo() {
    setState(() {
      // This should be changed with real data in future
      data.add(new MemoData(memo: _memo));
    });
  }

  final Geodesy _geodesy = Geodesy();

  TextEditingController _textEditingController = TextEditingController();

  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  double _axisAlignment = 1.0;

  _PlanListItemState(
      {required this.dateIndex,
      required this.incrementOpenedCount,
      required this.decrementOpenedCount,
      required this.mode}) {
    _expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _expandAnimation =
        CurvedAnimation(parent: _expandController, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    super.dispose();
    _expandController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* 
     * This variable is a list of widgets from a list of placeData, num, and null
     * which appear in the list in turn. For example:
     * [null, plaeData1, distanceBetween1N2, placeData2, ..., placeDataN, null]
     * null will be rendered as placeholder, placeData as schedule card, 
     * num as distance icon which indicates distance between 
     * former place and latter place
    */
    List<Widget> scheduleCardWidgets = data
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
              child: placeDataOrDistance is PlaceDataProps
                  ? ScheduleCard(
                      data: placeDataOrDistance,
                      order: (index + 2) ~/ 2,
                      mode: mode,
                    )
                  : placeDataOrDistance is num
                      ? buildMiddleDivider(placeDataOrDistance, mode)
                      : Center(
                          child: SizedBox(height: 27),
                        ),
            )))
        .values
        .toList();
    return Container(
      child: Container(
          child: Column(
            children: [
              buildScheduleCardsHeader(context),
              SizeTransition(
                  sizeFactor: _expandAnimation,
                  axisAlignment: _axisAlignment,
                  child: Column(
                    children: scheduleCardWidgets,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ))
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          padding: EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: const Color(0xff707070).withOpacity(0.52),
                      width: 0.5)))),
      padding: EdgeInsets.symmetric(horizontal: PlanListItemPadding),
    );
  }

  SizedBox buildMiddleDivider(num distance, PlanMakeMode mode) {
    if (mode == PlanMakeMode.delete) {
      return SizedBox(
        height: 27,
      );
    }

    if (mode == PlanMakeMode.edit) {
      return SizedBox(
        height: 27,
        child: Center(
          child: Text("붙여넣기",
              style: const TextStyle(
                  color: const Color(0xff707070),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 9.0),
              textAlign: TextAlign.center),
        ),
      );
    }

    return SizedBox(
      height: 27,
      child: Stack(children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: Text(distanceWithUnit(distance),
                  style: const TextStyle(
                      color: const Color(0xff4080ff),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 11.0),
                  textAlign: TextAlign.center),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: const Color(0xffbbd2ff), width: 1),
                  color: const Color(0xffffffff)),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
          ),
          top: -5,
        )
      ], clipBehavior: Clip.none),
    );
  }

  Container buildScheduleCardsHeader(BuildContext context) {
    PlanMakeCalendarModel calendarHandler =
        Provider.of<PlanMakeCalendarModel>(context);
    DateTime date =
        calendarHandler.datePoints[0]!.add(Duration(days: dateIndex));
    return Container(
      child: Row(
        children: [
          Container(
              child: Row(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text("${(dateIndex + 1).toString()} 일차",
                            style: const TextStyle(
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0),
                            textAlign: TextAlign.left),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                            "${date.month.toString()}.${date.day.toString()} ${Calendar().getWeekdayInKorean(date.weekday)}",
                            style: const TextStyle(
                                color: const Color(0xff505050),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 13.0),
                            textAlign: TextAlign.left),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                  ),
                  IconButton(
                      onPressed: data.length == 0
                          ? null
                          : () {
                              _toggleExpanded();
                            },
                      icon: _expanded
                          ? Image.asset(
                              'assets/icons/ic_calender_arrow_up_fold.png')
                          : Image.asset(
                              'assets/icons/ic_calender_arrow_down_unfold.png'))
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              constraints: BoxConstraints(minWidth: 150)),
          Container(
            child: Row(
              children: [
                IconButton(
                    onPressed: () async {
                      await displayMemoInputDialog(context,
                          _textEditingController, _setMemo, _createMemo);
                      _setExpanded(true);
                    },
                    icon:
                        Image.asset('assets/icons/ic_calender_memo_gray.png')),
                IconButton(
                    onPressed: () {
                      setState(() {
                        data.add(randomPlaceData());
                      });
                      _setExpanded(true);
                    },
                    icon: Image.asset('assets/icons/ic_calender_plus.png')),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}

mixin PlaceListItemHelper {
  PlaceDataProps randomPlaceData() {
    return pseudoPlaceData[Random().nextInt(pseudoPlaceData.length)];
  }

  Future<void> displayMemoInputDialog(
      BuildContext context,
      TextEditingController controller,
      void Function(String) setText,
      void Function() createMemo) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('메모 만들기'),
            content: TextField(
              onChanged: setText,
              controller: controller,
              decoration: InputDecoration(hintText: "메모를 작성해주세요!"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('취소'),
                onPressed: () {
                  setText("");
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text('만들기'),
                onPressed: () {
                  createMemo();
                  setText("");
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
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
