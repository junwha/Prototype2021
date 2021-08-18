import 'package:flutter/material.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/model/plan_make_calendar_model.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/contants.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/data_handler.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/helper.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/memo_dialog.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/schedule_cards_header.dart';
import 'package:provider/provider.dart';

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
    PlanMakeCalendarModel calendarHandler =
        Provider.of<PlanMakeCalendarModel>(context);
    List<PlaceDataProps> data = calendarHandler.planListItems?[dateIndex] ?? [];
    bool hasItem = data.length != 0;
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
                  child: Column(
                    children: placeDataToWidgets(data, dateIndex),
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
}
