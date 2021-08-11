import 'package:flutter/material.dart';
import 'package:prototype2021/theme/calendar/plan_make_calendar_handler.dart';
import 'package:provider/provider.dart';

class BottomCalendarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlanMakeCalendarHandler calendarHandler =
        Provider.of<PlanMakeCalendarHandler>(context);
    return Container(
      child: SafeArea(child: _buildButton(calendarHandler)),
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

  TextButton _buildButton(PlanMakeCalendarHandler calendarHandler) {
    String buttonText;
    Color buttonColor;
    Color textColor;
    bool disabled;
    if (calendarHandler.phase == CalendarTouchPhase.PENDING) {
      buttonText = "여행 일자를 선택하세요";
      buttonColor = Colors.grey.shade300;
      textColor = const Color(0xff484848);
      disabled = true;
    } else {
      buttonText = "${calendarHandler.dateDifference}일 선택완료";
      buttonColor = const Color(0xff4080ff);
      textColor = const Color(0xfff6f6f6);
      disabled = false;
    }
    return TextButton(
        child: Container(
          child: Center(
            child: Text(buttonText,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0),
                textAlign: TextAlign.center),
          ),
          height: 35,
          width: double.infinity,
        ),
        onPressed: disabled ? null : () {},
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0))),
            backgroundColor: MaterialStateProperty.all(buttonColor)));
  }
}
