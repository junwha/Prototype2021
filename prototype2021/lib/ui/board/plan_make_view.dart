import 'package:flutter/material.dart';
import 'package:prototype2021/theme/calendar/bottom_calendar_button.dart';
import 'package:prototype2021/theme/calendar/plan_make_calendar.dart';
import 'package:prototype2021/model/plan_make_calendar_model.dart';
import 'package:prototype2021/theme/calendar/plan_make_view_base.dart';
import 'package:provider/provider.dart';

class PlanMakeView extends StatelessWidget with PlanMakeViewBase {
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return ChangeNotifierProvider(
      create: (_) => PlanMakeCalendarModel(now: now),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: PlanMakeCalendar(),
        bottomNavigationBar: BottomCalendarButton(),
      ),
    );
  }
}
