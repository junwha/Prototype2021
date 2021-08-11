import 'package:flutter/material.dart';
import 'package:prototype2021/theme/calendar/calendar.dart';
import 'package:prototype2021/theme/calendar/plan_make_calendar_handler.dart';
import 'package:provider/provider.dart';

const double CalendarHorizontalPadding = 10;

class PlanMakeCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlanMakeCalendarHandler calendarHandler =
        Provider.of<PlanMakeCalendarHandler>(context);
    DateTime _now = new DateTime.now();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWeekdayBar(),
          _buildCalendars(calendarHandler, _now.year, _now.month),
        ],
      ),
    );
  }

  Container _buildWeekdayBar() {
    List<String> _weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
    return Container(
      child: GridView.count(
        crossAxisCount: 7,
        children: List.of(_weekdays.map((weekday) => Text(
              weekday,
              style: const TextStyle(
                  color: const Color(0xff0055ff),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 9.0),
              textAlign: TextAlign.center,
            ))),
        physics: const NeverScrollableScrollPhysics(),
      ),
      width: double.infinity,
      height: 40,
      decoration: new BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 1,
            offset: Offset(0.0, 0.75))
      ], color: const Color(0xfff6f6f6)),
      padding: EdgeInsets.symmetric(
          horizontal: 15, vertical: CalendarHorizontalPadding),
    );
  }

  Widget _buildCalendars(
      PlanMakeCalendarHandler calendarHandler, int year, int month) {
    List<int> months = List.generate(3, (index) => month + index);
    return Expanded(
      child: ListView(
        children: months
            .map((month) => _buildMonthlyCalendar(calendarHandler, year, month))
            .toList(),
        shrinkWrap: true,
      ),
    );
  }

  Container _buildMonthlyCalendar(
      PlanMakeCalendarHandler calendarHandler, int year, int month) {
    DateTime _convertedDateTime = new DateTime(year, month);
    List<DateTime?> _calendar = Calendar()
        .generateCalendar(_convertedDateTime.year, _convertedDateTime.month);
    bool _reverseAlign = _calendar[2] == null;

    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Text(_convertedDateTime.year.toString(),
                    style: const TextStyle(
                        color: const Color(0xff9dbeff),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0),
                    textAlign: TextAlign.center),
                SizedBox(
                  width: 10,
                  height: 1,
                ),
                Text("${_convertedDateTime.month.toString()}월",
                    style: const TextStyle(
                        color: const Color(0xff4080ff),
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 22.0),
                    textAlign: TextAlign.center)
              ],
              mainAxisAlignment: _reverseAlign
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: CalendarHorizontalPadding),
            alignment: Alignment.bottomCenter,
          ),
          Container(
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              children: _calendar
                  .asMap()
                  .map<int, Widget>((index, nullableDate) => MapEntry(
                      index,
                      nullableDate == null
                          ? _buildPlaceholder(
                              calendarHandler, index, year, month)
                          : _buildCalendarDate(calendarHandler, nullableDate)))
                  .values
                  .toList(),
              physics: const NeverScrollableScrollPhysics(),
            ),
            width: double.infinity,
            height: 300,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      padding: EdgeInsets.symmetric(
          vertical: 10, horizontal: CalendarHorizontalPadding),
    );
  }

  Container _buildPlaceholder(PlanMakeCalendarHandler calendarHandler,
      int dateIndex, int year, int month) {
    Color _backgroundColor = Colors.white;
    if (calendarHandler.phase == CalendarTouchPhase.RANGE) {
      List<DateTime?> _datePoints = calendarHandler.datePoints;
      List<int> _convertedMonths = _datePoints
          .map((datePoint) =>
              datePoint!.month + (datePoint.year - _datePoints[0]!.year) * 12)
          .toList();
      if (dateIndex < 7) {
        if (_convertedMonths[0] < month && _convertedMonths[1] >= month) {
          _backgroundColor = const Color(0xff4080ff);
        }
      } else {
        if (_convertedMonths[1] > month && _convertedMonths[0] <= month) {
          _backgroundColor = const Color(0xff4080ff);
        }
      }
    }

    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: _backgroundColor));
  }

  TextButton _buildCalendarDate(
      PlanMakeCalendarHandler calendarHandler, DateTime date) {
    TextDecoration textDecoration;
    Color textColor;
    bool disabled;
    Color backgroundColor;
    BorderRadius buttonBorderRadius = BorderRadius.zero;

    if (date.isBefore(calendarHandler.now)) {
      textDecoration = TextDecoration.lineThrough;
      textColor = const Color(0xff9dbeff);
      disabled = true;
      backgroundColor = Colors.white;
    } else {
      disabled = false;
      textDecoration = TextDecoration.none;
      if ((calendarHandler.phase == CalendarTouchPhase.RANGE &&
              ((date.isAtSameMomentAs(calendarHandler.datePoints[0]!) ||
                      date.isAfter(calendarHandler.datePoints[0]!)) &&
                  (date.isBefore(calendarHandler.datePoints[1]!) ||
                      date.isAtSameMomentAs(
                          calendarHandler.datePoints[1]!)))) ||
          (calendarHandler.phase == CalendarTouchPhase.POINT &&
              date.isAtSameMomentAs(calendarHandler.datePoints[0]!))) {
        textColor = const Color(0xfff6f6f6);
        backgroundColor = const Color(0xff4080ff);
      } else {
        textColor = const Color(0xff0055ff);
        backgroundColor = Colors.white;
      }
    }

    if (calendarHandler.phase == CalendarTouchPhase.POINT) {
      buttonBorderRadius = BorderRadius.circular(10);
    } else {
      if (calendarHandler.datePoints[0] != null &&
          date.isAtSameMomentAs(calendarHandler.datePoints[0]!)) {
        buttonBorderRadius = BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
      }

      if (calendarHandler.datePoints[1] != null &&
          date.isAtSameMomentAs(calendarHandler.datePoints[1]!)) {
        buttonBorderRadius = BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10));
      }
    }

    return TextButton(
        child: Text(date.day.toString(),
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
                decoration: textDecoration),
            textAlign: TextAlign.center),
        onPressed: disabled ? null : () => calendarHandler.handleTap(date),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: buttonBorderRadius, side: BorderSide.none),
            )));
  }
}
