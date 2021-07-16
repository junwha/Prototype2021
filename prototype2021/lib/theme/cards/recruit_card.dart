import "package:flutter/material.dart";
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/tag.dart';

// TODO(MINA): specify design
class RecruitCard extends StatelessWidget {
  String title;
  bool hasContents;
  DateTimeRange range; // DateTimeRange have to be checked earlier (start > end)
  int heartCount;
  int commentCount;
  Function()? onTap;

  RecruitCard(
      {required this.title,
      required this.hasContents,
      required this.range,
      this.heartCount = 0,
      this.commentCount = 0,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.fromLTRB(20 * pt, 10 * pt, 20 * pt, 10 * pt),
            child: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      Text(
                        "${this.title}",
                        style: TextStyle(
                            fontSize: 14 * pt, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      hasContents
                          ? ContentTag(tagName: "컨텐츠")
                          : SizedBox(width: 9 * pt),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/calender_outlined.png"),
                          SizedBox(width: 8 * pt),
                          Text(
                              "${range.start.year}.${range.start.month}.${range.start.day}(${getWeekDay(range.start.weekday)})~${range.end.year}.${range.end.month}.${range.end.day}(${getWeekDay(range.end.weekday)})")
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset("assets/icons/heart_outlined.png"),
                          SizedBox(width: 10 * pt),
                          Text("${this.heartCount}"),
                          SizedBox(width: 8 * pt),
                          Image.asset("assets/icons/message_outlined.png"),
                          SizedBox(width: 10 * pt),
                          Text("${this.commentCount}")
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  String getWeekDay(int i) {
    // Convert week days to korean from index
    switch (i) {
      case 1:
        return "월";
      case 2:
        return "화";
      case 3:
        return "수";
      case 4:
        return "목";
      case 5:
        return "금";
      case 6:
        return "토";
      case 7:
        return "일";
    }

    return "";
  }
}
