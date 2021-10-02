import 'package:flutter/material.dart';
import 'package:prototype2021/theme/pop_up.dart';
import 'package:prototype2021/ui/event/event_main_view.dart';
import 'package:prototype2021/ui/signin_page/signin_view_3.dart';

mixin EventFilter on State<EventMainView> {
  Widget buildFilterView(
      Map<Gender, bool> isGenderSelected, Function(Gender) genderSetter) {
    return TBLargeDialog(
      title: "",
      insetsPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      padding: EdgeInsets.all(20),
      body: SingleChildScrollView(
        child: Column(
          children: [buildGenderSelector(isGenderSelected, genderSetter)],
        ),
      ),
    );
  }

  Row buildGenderSelector(
      Map<Gender, bool> isGenderSelected, Function(Gender) genderSetter) {
    return Row(
      children: [
        buildGenderButton("무관", isGenderSelected[Gender.OTHER]!, () {
          genderSetter(Gender.OTHER);
        }),
        SizedBox(width: 10),
        buildGenderButton("남성", isGenderSelected[Gender.MALE]!, () {
          genderSetter(Gender.MALE);
        }),
        SizedBox(width: 10),
        buildGenderButton("여성", isGenderSelected[Gender.FEMALE]!, () {
          genderSetter(Gender.FEMALE);
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
}
