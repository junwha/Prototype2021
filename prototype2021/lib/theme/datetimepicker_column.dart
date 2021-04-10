import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimePickerCol extends StatefulWidget {
  DateTime chosenDateTime1;
  DateTime chosenDateTime2;

  DateTimePickerCol(DateTime chosenDateTime1, DateTime chosenDateTime2) {
    this.chosenDateTime1 = chosenDateTime1;
    this.chosenDateTime2 = chosenDateTime2;
  }

  @override
  _DateTimePickerColState createState() => _DateTimePickerColState();
}

class _DateTimePickerColState extends State<DateTimePickerCol> {
  String resultString;
  DateTime chosenDateTime1;
  DateTime chosenDateTime2;

  void showDatePicker1(ctx1) {
    showCupertinoModalPopup(
        context: ctx1,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val1) {
                          setState(() {
                            this.widget.chosenDateTime1 = val1;
                          });
                        }),
                  ),
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(ctx1).pop(),
                  )
                ],
              ),
            ));
  }

  void showDatePicker2(ctx2) {
    showCupertinoModalPopup(
        context: ctx2,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val2) {
                          setState(() {
                            this.widget.chosenDateTime2 = val2;
                          });
                        }),
                  ),
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(ctx2).pop(),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("시작날짜"),
            SizedBox(
              width: 40,
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text('날짜선택',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black)),
              onPressed: () => showDatePicker1(context),
            ),
          ],
        ),
        Text(this.widget.chosenDateTime1 != null
            ? this.widget.chosenDateTime1.toString()
            : '선택안함'),
        Row(
          children: [
            Text("종료날짜"),
            SizedBox(
              width: 40,
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text('날짜선택',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black)),
              onPressed: () => showDatePicker2(context),
            ),
          ],
        ),
        Text(this.widget.chosenDateTime2 != null
            ? this.widget.chosenDateTime2.toString()
            : '선택안함'),
      ],
    );
  }
}
