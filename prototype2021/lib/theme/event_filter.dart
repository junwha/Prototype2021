import 'package:flutter/material.dart';
import 'package:prototype2021/model/safe_http_dto/post/signup.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/pop_up.dart';
import 'package:prototype2021/theme/tb_drop_down_button.dart';
import 'package:prototype2021/ui/event/event_main_view.dart';

/// 이벤트 필터 뷰를 구성하는
mixin EventFilter<T extends StatefulWidget> on State<T> {
  Widget buildFilterView(
    Map<Gender, bool> isGenderSelected,
    Function(Gender) genderSetter,
    RangeValues ageRange,
    Function(RangeValues) ageSetter,
    DateTimeRange dateRange,
    Function(DateTimeRange) dateRangeSetter,
  ) {
    return TBLargeDialog(
      title: "이벤트/동행찾기",
      insetsPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 70),
      padding: EdgeInsets.symmetric(horizontal: 20),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildText("성별"),
            buildGenderSelector(isGenderSelected, genderSetter),
            buildDivider(),
            buildText("나이"),
            buildAgeSelector(ageRange, ageSetter, RangeValues(0, 100)),
            buildSliderText("0세", "100세"),
            buildDivider(),
            buildText("날짜"),
            buildDateSelector(dateRange, dateRangeSetter),
          ],
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        height: 1,
        color: Color(0xffe6e6e6));
  }

  Widget buildText(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16 * pt,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  /// build gender select buttons with gender setter
  Row buildGenderSelector(
      Map<Gender, bool> isGenderSelected, Function(Gender) genderSetter) {
    return Row(
      children: [
        buildGenderButton("무관", isGenderSelected[Gender.None]!, () {
          genderSetter(Gender.None);
        }),
        SizedBox(width: 10),
        buildGenderButton("남성", isGenderSelected[Gender.M]!, () {
          genderSetter(Gender.M);
        }),
        SizedBox(width: 10),
        buildGenderButton("여성", isGenderSelected[Gender.F]!, () {
          genderSetter(Gender.F);
        }),
      ],
    );
  }

  Widget buildGenderButton(String text, bool isSelected, Function() onPressed) {
    return Expanded(
      child: Container(
        height: 45,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: isSelected ? Color(0xff4080ff) : Colors.white,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xffbdbdbd),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAgeSelector(RangeValues ageRange, Function(RangeValues) ageSetter,
      RangeValues ageMinMax) {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: RoundedRectSliderTrackShape(),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
      ),
      child: RangeSlider(
          values: ageRange,
          min: ageMinMax.start,
          max: ageMinMax.end,
          divisions: 20,
          labels: RangeLabels(
            ageRange.start.round().toString(),
            ageRange.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            ageSetter(values);
          }),
    );
  }

  /// this texts are placed with space between
  Widget buildSliderText(String start, String end) {
    TextStyle sliderTextStyle = TextStyle(
      color: Color(0xff707070),
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          start,
          style: sliderTextStyle,
        ),
        Text(
          end,
          style: sliderTextStyle,
        ),
      ],
    );
  }

  /// Select DateTimeRange with OutliendButton
  Widget buildDateSelector(
      DateTimeRange dateRange, Function(DateTimeRange) dateRangeSetter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildDateButton(buildDateText(dateRange.start), () async {
          DateTime start = await getDateTime() ?? dateRange.start;
          dateRangeSetter(DateTimeRange(start: start, end: dateRange.end));
        }),
        Text("~"),
        buildDateButton(buildDateText(dateRange.end), () async {
          DateTime end = await getDateTime() ?? dateRange.end;
          dateRangeSetter(DateTimeRange(start: dateRange.start, end: end));
        })
      ],
    );
  }

  String buildDateText(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }

  Widget buildDateButton(String dateText, Function() onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(dateText),
    );
  }

  Future<DateTime?> getDateTime() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child ?? SizedBox(),
        );
      },
    );
  }
}
