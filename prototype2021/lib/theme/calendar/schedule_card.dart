import 'package:flutter/material.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/model/plan_make_calendar_model.dart';
import 'package:prototype2021/theme/calendar/plan_make_home.dart';
import 'package:prototype2021/theme/calendar/plan_make_home/constants.dart';
import 'package:prototype2021/theme/calendar/schedule_card/actions.dart';
import 'package:prototype2021/theme/calendar/schedule_card/helper.dart';
import 'package:prototype2021/theme/calendar/schedule_card/leading.dart';
import 'package:provider/provider.dart';

class ScheduleCard extends StatelessWidget
    with
        ScheduleCardLeadingMixin,
        ScheduleCardActionsMixin,
        ScheduleCardHelpers {
  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

  final PlaceDataProps data;
  final int dateIndex;
  final int order;

  void Function() deleteSelfFuncFactory(PlanMakeCalendarModel calendarHandler) {
    return () {
      calendarHandler.deletePlaceData(dateIndex, order);
    };
  }

  /* =================================/================================= */
  /* =================CONSTRUCTORS & LIFE CYCLE METHODS================= */
  /* =================================/================================= */

  ScheduleCard(
      {required this.data, required this.dateIndex, required this.order});

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

  @override
  Widget build(BuildContext context) {
    String types = data.types;
    return Container(
      child: Container(
          child: Row(
            children: [
              Container(
                child: Row(
                  children: [
                    buildLeading(types, order, placeColorByType(types)),
                    SizedBox(
                      width: 10,
                    ),
                    buildInfo(data)
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
              buildActions(context, types, placeIconByType(types)),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(3, 3),
                    blurRadius: 3,
                    spreadRadius: 0)
              ],
              color: const Color(0xffffffff))),
      padding: EdgeInsets.only(right: 4),
    );
  }

  Container buildActions(BuildContext context, String types, Widget icon) {
    PlanMakeCalendarModel calendarHandler =
        Provider.of<PlanMakeCalendarModel>(context);
    PlanMakeHomeState? grandParent =
        context.findAncestorStateOfType<PlanMakeHomeState>();
    PlanMakeMode mode = grandParent?.mode ?? PlanMakeMode.add;
    switch (mode) {
      case PlanMakeMode.edit:
        return buildEditActions(context);
      case PlanMakeMode.delete:
        return buildDeleteActions(
            context, deleteSelfFuncFactory(calendarHandler));
      default:
        return buildDefaultActions(context, types, icon);
    }
  }
}
