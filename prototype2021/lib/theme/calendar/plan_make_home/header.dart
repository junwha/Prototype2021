import 'package:flutter/material.dart';
import 'package:prototype2021/model/plan_make_calendar_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/calendar/plan_make_calendar.dart';
import 'package:prototype2021/theme/circular_wrapper.dart';
import 'package:provider/provider.dart';

mixin PlanMakeHomeHeaderMixin {
  Container buildHeader(BuildContext context) {
    return Container(
      child: Row(
        children: [buildHeaderLeading(), buildHeaderActions(context)],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      padding: EdgeInsets.only(top: 50 * pt, left: 40, right: 40, bottom: 10),
    );
  }

  Container buildHeaderLeading() {
    return Container(
      child: Row(
        children: [
          Text("여행 일정",
              style: const TextStyle(
                  color: const Color(0xff4080ff),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 22.0),
              textAlign: TextAlign.left),
          SizedBox(width: 5),
          Text("짜기",
              style: const TextStyle(
                  color: const Color(0xff9dbeff),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0),
              textAlign: TextAlign.left)
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
      ),
    );
  }

  Container buildHeaderActions(BuildContext context) {
    PlanMakeCalendarModel calendarHandler =
        Provider.of<PlanMakeCalendarModel>(context);
    return Container(
      child: Row(
        children: [
          CircularWrapper(
            icon: Image.asset('assets/icons/map.png'),
            onTap: () {},
            size: 34,
            shadow: true,
          ),
          SizedBox(
            width: 10 * pt,
          ),
          CircularWrapper(
            icon: Image.asset('assets/icons/ic_calender_calender.png'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return ChangeNotifierProvider(
                  create: (_) => calendarHandler.inherit(),
                  child: PlanMakeCalendar(),
                );
              }));
            },
            size: 34,
            shadow: true,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
