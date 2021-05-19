import "package:flutter/material.dart";

// TODO(MINA): specify design
class RecruitCard extends StatelessWidget {
  String title;
  String description;
  bool hasContents;
  DateTimeRange range;
  int heartCount;
  int commentCount;

  RecruitCard(
      {required this.title,
      required this.description,
      required this.hasContents,
      required this.range,
      this.heartCount = 0,
      this.commentCount = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Text("태화강 근처"),
              hasContents ? ContentTag(tagName: "컨텐츠") : SizedBox(),
            ],
          ),
          Text(description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today_outlined),
                  SizedBox(width: 2.0),
                  Text(
                      "${range.start.year}.${range.start.month}.${range.start.day}(${getWeekDay(range.start.weekday)})~${range.end.year}.${range.end.month}.${range.end.day}(${getWeekDay(range.end.weekday)})")
                ],
              ),
              Row(
                children: [
                  Icon(Icons.favorite),
                  SizedBox(width: 2.0),
                  Text("${this.heartCount}"),
                  SizedBox(width: 2.0),
                  Icon(Icons.comment_outlined),
                  SizedBox(width: 2.0),
                  Text("${this.commentCount}")
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  String getWeekDay(int i) {
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

class ContentTag extends StatelessWidget {
  String tagName;
  Color? background;
  Color? textColor;

  ContentTag({required this.tagName, this.background, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: 50,
        height: 25,
        decoration: BoxDecoration(
          color: background ?? Colors.blue[400],
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Text(
          tagName,
          style: TextStyle(color: textColor ?? Colors.white),
        ));
  }
}
