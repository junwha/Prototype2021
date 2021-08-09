import 'package:flutter/material.dart';
import 'package:prototype2021/theme/calendar/plan_make_calendar_handler.dart';
import 'package:provider/provider.dart';

class BottomCalendarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlanMakeCalendarHandler calendarHandler = Provider.of(context);
    return Container(
      child: SafeArea(child: buildButton(calendarHandler)),
      width: double.infinity,
      decoration:
          BoxDecoration(color: const Color(0xfff6f6f6), boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 1,
            offset: Offset(0.0, -0.75))
      ]),
      padding: EdgeInsets.all(5.0),
    );
  }

  TextButton buildButton(PlanMakeCalendarHandler calendarHandler) {
    return TextButton(
        child: Container(
          child: Center(
            child: Text("여행 일자를 선택하세요.",
                style: const TextStyle(
                    color: const Color(0xff484848),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0),
                textAlign: TextAlign.center),
          ),
          height: 35,
          width: double.infinity,
        ),
        onPressed: () {},
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0))),
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade300)));
  }
}
