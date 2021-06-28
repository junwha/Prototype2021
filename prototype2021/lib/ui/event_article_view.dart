import 'package:prototype2021/theme/recruit_card.dart';
import 'package:flutter/material.dart';

class EventArticleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 35,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.people_alt_outlined,
                  color: Colors.black,
                  size: 35,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                  size: 35,
                )),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            RecruitCard(
              title: '울산대 공원에서 간단히 피맥해요!',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 01, 05),
                  start: DateTime.utc(2020, 01, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '벚꽃놀이 하러가요',
              range: DateTimeRange(
                  end: DateTime.utc(2021, 01, 05),
                  start: DateTime.utc(2021, 01, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '명장스시 가실 분?',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 02, 15),
                  start: DateTime.utc(2020, 02, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '태화강에서 치맥 하실분 구해요!',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 01, 06),
                  start: DateTime.utc(2020, 01, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '태화강에서 치맥 하실분 구해요!',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 01, 06),
                  start: DateTime.utc(2020, 01, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '태화강에서 치맥 하실분 구해요!',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 01, 06),
                  start: DateTime.utc(2020, 01, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '태화강에서 치맥 하실분 구해요!',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 01, 06),
                  start: DateTime.utc(2020, 01, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '태화강에서 치맥 하실분 구해요!',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 01, 06),
                  start: DateTime.utc(2020, 01, 04)),
              hasContents: false,
            ),
          ],
        )));
  }
}
