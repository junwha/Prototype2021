import 'package:flutter/material.dart';

void main() {
  runApp(
    //Don't touch here. route map is in 'main_page.dart'
    MaterialApp(home: PlanGrid(), routes: {}),
  );
}

class PlanGrid extends StatefulWidget {
  @override
  _PlanGridState createState() => _PlanGridState();
}

class _PlanGridState extends State<PlanGrid> {
  List<bool> isChecked = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 100,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                buildCheckBox(0, '날짜'),
                Container(height: 80, width: 1.5, color: Colors.grey[200]),
                buildCheckBox(1, '여행지'),
              ],
            ),
            Container(height: 1.5, width: 500, color: Colors.grey[200]),
            Row(
              children: [
                buildCheckBox(2, '음식점'),
                Container(height: 80, width: 1.5, color: Colors.grey[200]),
                buildCheckBox(3, '숙소'),
              ],
            ),
            Container(height: 1.5, width: 500, color: Colors.grey[200]),
            Row(
              children: [
                buildCheckBox(4, '이동수단'),
                Container(height: 80, width: 1.5, color: Colors.grey[200]),
                buildCheckBox(5, '무계획'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCheckBox(int i, String _text) {
    return Expanded(
      child: FlatButton(
        height: 80,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: isChecked[i] ? Colors.greenAccent[100] : Colors.white,
        onPressed: () {
          setState(() {
            isChecked[i] = isChecked[i] ? false : true;
          });
        },
        child: Text(
          _text,
          style: TextStyle(color: Colors.black54, fontSize: 20),
        ),
      ),
    );
  }
}
