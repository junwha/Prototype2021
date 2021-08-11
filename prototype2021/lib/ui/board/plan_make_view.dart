import 'package:flutter/material.dart';
import 'package:prototype2021/theme/calendar/bottom_calendar_button.dart';
import 'package:prototype2021/theme/calendar/plan_make_calendar.dart';
import 'package:prototype2021/model/plan_make_calendar_model.dart';
import 'package:provider/provider.dart';

class PlanMakeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return ChangeNotifierProvider(
      create: (_) => PlanMakeCalendarModel(now: now),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: PlanMakeCalendar(),
        bottomNavigationBar: BottomCalendarButton(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xfff6f6f6),
      shadowColor: const Color(0xfff6f6f6),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset('assets/icons/ic_arrow_left_back.png')),
      toolbarHeight: 60,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/ic_hamburger_menu.png'))
      ],
    );
  }
}
