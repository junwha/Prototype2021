import 'package:flutter/material.dart';

class CheckboxRow extends StatefulWidget {
  bool value1;
  bool value2;
  Function onChanged1;
  Function onChanged2;

  CheckboxRow(
      {bool value1, Function onChanged1, bool value2, Function onChanged2}) {
    this.value1 = value1;
    this.value2 = value2;
    this.onChanged1 = onChanged1;
    this.onChanged2 = onChanged2;
  }

  @override
  _CheckboxRowState createState() => _CheckboxRowState();
}

class _CheckboxRowState extends State<CheckboxRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("이벤트 정보",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        Row(
          children: [
            Text("성별무관",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
            Checkbox(
              value: this.widget.value1,
              onChanged: this.widget.onChanged1,
            ),
            Text("나이무관",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
            Checkbox(
              value: this.widget.value2,
              onChanged: this.widget.onChanged2,
            ),
          ],
        ),
      ],
    );
  }
}
