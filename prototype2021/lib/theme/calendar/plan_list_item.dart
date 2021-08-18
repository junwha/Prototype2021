import 'package:flutter/material.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/model/plan_make_calendar_model.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/contants.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/data_handler.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/helper.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/memo_dialog.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/schedule_cards_header.dart';
import 'package:prototype2021/theme/calendar/plan_make_home.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class PlanListItem extends StatefulWidget {
  final int dateIndex;
  final Function() incrementOpenedCount;
  final Function() decrementOpenedCount;
  PlanListItem({
    required this.dateIndex,
    required this.incrementOpenedCount,
    required this.decrementOpenedCount,
  });

  @override
  PlanListItemState createState() => PlanListItemState(
        dateIndex: dateIndex,
        incrementOpenedCount: incrementOpenedCount,
        decrementOpenedCount: decrementOpenedCount,
      );
}

class PlanListItemState extends State<PlanListItem>
    with
        SingleTickerProviderStateMixin,
        /* 
         * These Mixins below have children widgets and helper Functions 
         * PlanMakeHome widget uses 
        */
        PlanListItemMemoDialogMixin,
        PlanListItemDataHandlerMixin,
        PlanListItemHelper {
  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

  final int dateIndex;
  final Function() incrementOpenedCount;
  final Function() decrementOpenedCount;

  bool expanded = false;
  void setExpanded(bool isExpanded) {
    if (isExpanded) {
      incrementOpenedCount();
      _expandController.forward();
    } else {
      decrementOpenedCount();
      _expandController.reverse();
    }
    setState(() {
      expanded = isExpanded;
    });
  }

  void toggleExpanded() {
    setExpanded(!expanded);
  }

  void Function() Function(int) deleteSelfFuncFactory(
      PlanMakeCalendarModel calendarHandler) {
    return (int order) {
      return () {
        calendarHandler.deletePlaceData(dateIndex, order);
      };
    };
  }

  List<int> _convertIndexes(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      return [1];
    }
    return [0];
  }

  int _toDataIndex(int widgetIndex) {
    if (widgetIndex % 2 == 1) {
      widgetIndex += 1;
    }
    return ((widgetIndex / 2) - 1).toInt();
  }

  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  double _axisAlignment = 1.0;

  /* =================================/================================= */
  /* =================CONSTRUCTORS & LIFE CYCLE METHODS================= */
  /* =================================/================================= */

  PlanListItemState({
    required this.dateIndex,
    required this.incrementOpenedCount,
    required this.decrementOpenedCount,
  }) {
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

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

  @override
  Widget build(BuildContext context) {
    PlanMakeHomeState? parent =
        context.findAncestorStateOfType<PlanMakeHomeState>();

    PlanMakeCalendarModel calendarHandler =
        Provider.of<PlanMakeCalendarModel>(context);
    List<PlaceDataProps> data = calendarHandler.planListItems?[dateIndex] ?? [];
    bool hasItem = data.length != 0;
    void _onReorder(int oldIndex, int newIndex) {
      parent?.setOnDrag(false);
      calendarHandler.swapPlaceData(
          dateIndex, _toDataIndex(oldIndex), _toDataIndex(newIndex));
    }

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (expanded && !hasItem) {
        setExpanded(false);
      }
    });
    return Container(
      child: Container(
          child: Column(
            children: [
              ScheduleCardsHeader(
                dateIndex: dateIndex,
              ),
              SizeTransition(
                  sizeFactor: _expandAnimation,
                  axisAlignment: _axisAlignment,
                  child: Container(
                    child: ReorderableListView(
                      onReorder: _onReorder,
                      buildDefaultDragHandles: false,
                      children: placeDataToWidgets(data, dateIndex,
                          deleteSelfFuncFactory(calendarHandler)),
                      shrinkWrap: true,
                      physics: new NeverScrollableScrollPhysics(),
                    ),
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
}
