import 'package:flutter/material.dart';

class CheckboxRow extends StatefulWidget {
  //fields for check box
  bool value1;
  bool value2;
  Function(bool?) onChanged1;
  Function(bool?) onChanged2;

  /*
  * Widget for Combining CheckBox
  * value1, onChanged1, value2  onChanged2 are corresponding to each parameters of checkboxes
  */
  CheckboxRow(
      {required this.value1,
      required this.onChanged1,
      required this.value2,
      required this.onChanged2});
  //If it have to be used in other classes, please add some parameters and generalize texts.

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
