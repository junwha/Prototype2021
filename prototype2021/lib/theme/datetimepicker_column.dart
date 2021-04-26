import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimePickerCol extends StatefulWidget {
  DateTime? chosenDateTime;
  DateTime? chosenDateTime2;

  DateTimePickerCol(DateTime chosenDateTime1) {
    this.chosenDateTime = chosenDateTime;
  }

  @override
  _DateTimePickerColState createState() => _DateTimePickerColState();
}

class _DateTimePickerColState extends State<DateTimePickerCol> {
  String? resultString;

  DateTime? chosenDateTime;

  void showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            this.widget.chosenDateTime = val;
                          });
                        }),
                  ),
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
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
              onPressed: () => showDatePicker(context),
            ),
          ],
        ),
        Text(this.widget.chosenDateTime != null
            ? this.widget.chosenDateTime.toString()
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
              onPressed: () => showDatePicker(context),
            ),
          ],
        ),
        Text(this.widget.chosenDateTime != null
            ? this.widget.chosenDateTime.toString()
            : '선택안함'),
      ],
    );
  }
}
