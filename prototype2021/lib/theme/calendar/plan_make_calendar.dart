import 'package:flutter/material.dart';
import 'package:prototype2021/theme/calendar/calendar.dart';

const double CalendarHorizontalPadding = 10;

class PlanMakeCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime _now = new DateTime.now();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWeekdayBar(),
          _buildCalendars(_now.year, _now.month),
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

  Widget _buildCalendars(int year, int month) {
    List<int> months = List.generate(3, (index) => month + index);
    return Expanded(
      child: ListView(
        children:
            months.map((month) => _buildMonthlyCalendar(year, month)).toList(),
        shrinkWrap: true,
      ),
    );
  }

  Container _buildMonthlyCalendar(int year, int month) {
    List<DateTime?> _calendar = Calendar().generateCalendar(year, month);

    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Text(year.toString(),
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
                Text("$month월",
                    style: const TextStyle(
                        color: const Color(0xff4080ff),
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 22.0),
                    textAlign: TextAlign.center)
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: CalendarHorizontalPadding),
          ),
          Container(
            child: GridView.count(
              crossAxisCount: 7,
              children:
                  List.of(_calendar.map((nullableDate) => nullableDate == null
                      ? SizedBox(
                          width: 1,
                          height: 1,
                        )
                      : buildCalendarDate(nullableDate))),
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

  TextButton buildCalendarDate(DateTime date) {
    return TextButton(
      child: Text(date.day.toString(),
          style: const TextStyle(
              color: const Color(0xff0055ff),
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 16.0),
          textAlign: TextAlign.center),
      onPressed: () {},
    );
  }
}
