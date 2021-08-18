import 'package:flutter/material.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/contants.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/data_handler.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/helper.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/memo_dialog.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/schedule_cards_header.dart';
import 'package:prototype2021/theme/calendar/plan_make_home/constants.dart';

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
  List<PlaceDataProps> data = [];
  void _addPlaceData(PlaceDataProps placeData) {
    setState(() {
      data.add(placeData);
    });
  }

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

  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  double _axisAlignment = 1.0;

  /* =================================/================================= */
  /* =================CONSTRUCTORS & LIFE CYCLE METHODS================= */
  /* =================================/================================= */

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

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          child: Column(
            children: [
              ScheduleCardsHeader(
                  dateIndex: dateIndex,
                  listHasItem: data.length == 0,
                  toggleExpanded: _toggleExpanded,
                  expanded: _expanded,
                  setExpanded: _setExpanded,
                  addPlaceData: _addPlaceData),
              SizeTransition(
                  sizeFactor: _expandAnimation,
                  axisAlignment: _axisAlignment,
                  child: Column(
                    children: placeDataToWidgets(data, mode),
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
