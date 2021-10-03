import 'package:flutter/material.dart';
import 'package:prototype2021/handler/board/plan/plan_make_calendar_model.dart';
import 'package:prototype2021/views/board/plan/make/calendar/plan_make_calendar.dart';
import 'package:provider/provider.dart';

class PlanMakeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return ChangeNotifierProvider(
        create: (_) => PlanMakeCalendarModel(now: now),
        child: PlanMakeCalendar());
  }
}
