import 'package:flutter/material.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/model/plan_make_calendar_model.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/contants.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/data_handler.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/helper.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/memo_dialog.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/schedule_cards_header.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/schedule_cards_sub_header.dart';
import 'package:prototype2021/theme/calendar/plan_make_home.dart';
import 'package:prototype2021/theme/calendar/plan_make_home/constants.dart';
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
        PlanListItemSubHeaderMixin,
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
      _mainExpandController.forward();
    } else {
      decrementOpenedCount();
      _mainExpandController.reverse();
    }
    setState(() {
      expanded = isExpanded;
    });
  }

  void toggleExpanded() {
    setExpanded(!expanded);
  }

  /* 
   * 아래와 같이 여러개의 층으로 이루어져 있는 함수 팩토리를 만든 이유는 
   * schedule_card 가 드래그되고 있는 상태일 때 
   * PlanMakeCalendarModel에 접근할 수 있는 context를 벗어나기 때문에 
   * 항상 PlanMakeCalendarModel에 접근 가능하면서 schedule_card와 
   * 위젯트리 상으로 가장 가까운 PlanListItem 클래스에 아래와 같은 메소드를 정의해 놓은 것입니다. 
  */
  void Function() Function(int) deleteSelfFuncFactory(
      PlanMakeCalendarModel calendarHandler) {
    return (int order) {
      return () {
        calendarHandler.deletePlaceData(dateIndex, order);
      };
    };
  }

  List<int> _convertIndexes(int oldIndex, int newIndex) {
    if (oldIndex > newIndex) {
      return [_toDataIndex(oldIndex), _toDataIndex(newIndex + newIndex % 2)];
    }
    return [
      _toDataIndex(oldIndex),
      _toDataIndex(newIndex - (newIndex % 2 == 0 ? 1 : 0))
    ];
  }

  int _toDataIndex(int widgetIndex) => (widgetIndex ~/ 2);

  late AnimationController _mainExpandController;
  late Animation<double> _mainExpandAnimation;
  double _axisAlignment = 1.0;

  /* =================================/================================= */
  /* =================CONSTRUCTORS & LIFE CYCLE METHODS================= */
  /* =================================/================================= */

  PlanListItemState({
    required this.dateIndex,
    required this.incrementOpenedCount,
    required this.decrementOpenedCount,
  }) {
    _mainExpandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _mainExpandAnimation = CurvedAnimation(
        parent: _mainExpandController, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    super.dispose();
    _mainExpandController.dispose();
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
    bool onDrag = parent?.onDrag ?? false;
    PlanMakeMode mode = parent?.mode ?? PlanMakeMode.add;
    void _onReorder(int oldIndex, int newIndex) {
      parent?.setOnDrag(false);
      List<int> convertedIndexes = _convertIndexes(oldIndex, newIndex);
      calendarHandler.swapPlaceData(
          dateIndex, convertedIndexes[0], convertedIndexes[1]);
    }

    void _pasteData() {
      PlaceDataProps? data = parent?.copiedData;
      if (data != null) {
        int indexToInsert = 0;
        parent?.insertCopiedData(
            calendarHandler, dateIndex, data, indexToInsert);
        parent?.setCopiedData(null, null);
        setExpanded(true);
      }
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
              buildScheduleCardsSubHeader(mode, hasItem, onDrag, _pasteData),
              SizeTransition(
                  sizeFactor: _mainExpandAnimation,
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
