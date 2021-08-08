import 'package:flutter/material.dart';
import 'package:prototype2021/theme/calendar/calendar.dart';
import 'package:prototype2021/theme/calendar/calendar_handler.dart';
import 'package:prototype2021/ui/board/board_main_view.dart';
import 'package:provider/provider.dart';

class PlanMakeView extends StatefulWidget {
  const PlanMakeView();

  @override
  _PlanMakeViewState createState() => _PlanMakeViewState();
}

class _PlanMakeViewState extends State<PlanMakeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff6f6f6),
        appBar: buildAppBar(),
        body: Container(
          child: Calendar(),
        ));
  }

  AppBar buildAppBar() {
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
