import "package:flutter/material.dart";
import 'dart:async';
import 'package:prototype2021/settings/constants.dart';

//TODO(mina): specify design
class TimerCard extends StatefulWidget {
  String title;
  String description;
  DateTime due;
  Function? onEnd; // onEnd function is called when time out

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
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 75 * pt,
          color: Colors.grey[200],
          child: Padding(
            padding:
                const EdgeInsets.fromLTRB(20 * pt, 10 * pt, 20 * pt, 10 * pt),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${this.widget.title}",
                          style: TextStyle(
                              fontSize: 14 * pt, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              remainTime.inDays > 0
                                  ? "${remainTime.inDays}일 ${remainTime.inHours - remainTime.inDays * 24}시간"
                                  : "${remainTime.toString().split(".")[0]}",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14 * pt),
                            ), // Converts Datetime to time format
                            SizedBox(width: 10),
                            Text(
                              "남음",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14 * pt),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 9 * pt,
                    ),
                    Text(
                      "${this.widget.description}",
                      maxLines: 1,
                      style: TextStyle(fontSize: 12 * pt),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1.5,
          color: Colors.white,
        )
      ],
    );
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Asynchronized timer function is called by 1 second
      setState(() {
        // rebuild widget with newly calculated difference
        remainTime = this.widget.due.difference(DateTime.now());
      });

      if (remainTime.isNegative) {
        // if difference is negative, stop timer and call onEnd function
        timer.cancel();
        if (this.widget.onEnd != null) {
          this.widget.onEnd!();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // if widget disposed unexpectly, cancel timer
    _timer?.cancel();
    super.dispose();
  }
}
