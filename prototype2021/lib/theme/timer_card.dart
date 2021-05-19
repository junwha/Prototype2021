import "package:flutter/material.dart";
import 'dart:async';

//TODO(mina): specify design
class TimerCard extends StatefulWidget {
  String title;
  String description;
  DateTime due;
  Function? onEnd;

  TimerCard(
      {required this.title,
      required this.description,
      required this.due,
      this.onEnd});
  @override
  _TimerCardState createState() => _TimerCardState();
}

class _TimerCardState extends State<TimerCard> {
  Duration remainTime = Duration();
  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    remainTime = this.widget.due.difference(DateTime.now());
    dateTimer(this.widget.due, this.widget.onEnd);
    return Container(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${this.widget.title}"),
              Row(
                children: [
                  Text("${remainTime.toString().split(".")[0]}"),
                  SizedBox(width: 10),
                  Text("남음"),
                ],
              ),
            ],
          ),
          Text("${this.widget.description}"),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void dateTimer(DateTime due, Function? onEnd) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainTime = this.widget.due.difference(DateTime.now());
      });

      if (!remainTime.isNegative) {
        setState(() {
          timer.cancel();
          onEnd!();
        });
      }
    });
  }
}
