import 'package:flutter/material.dart';
import 'package:prototype2021/theme/recruit_card.dart';

class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            RecruitCard(
                title: "태화강 근처",
                description: "UNIST is the best",
                hasContents: true,
                range: DateTimeRange(
                    start: DateTime(2021, 5, 23, 3, 10),
                    end: DateTime(2021, 5, 25, 3, 10))),
          ],
        ),
      ),
    );
  }
}
