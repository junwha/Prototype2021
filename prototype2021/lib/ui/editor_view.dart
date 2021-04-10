import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype2021/theme/checkbox_row.dart';
import 'package:prototype2021/theme/datetimepicker_column.dart';
import 'package:prototype2021/theme/checkbox_widget.dart';

class EditorView extends StatefulWidget {
  @override
  _EditorViewState createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  var _isChecked1 = false;
  var _isChecked2 = false;
  List<bool> ischeckedbutton = [false, false];
  DateTime chosenDateTime1;
  DateTime chosenDateTime2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Cupertino Date Picker',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                OutlinedButton(
                  style: ButtonStyle(side:
                      MaterialStateProperty.resolveWith<BorderSide>(
                          (Set<MaterialState> states) {
                    final Color color =
                        ischeckedbutton[0] ? Colors.blue : Colors.grey;
                    return BorderSide(color: color, width: 2);
                  })),
                  onPressed: () {
                    setState(() {
                      ischeckedbutton[0] = ischeckedbutton[0] ? false : true;
                    });
                  },
                  child: Text(
                    "내 주변 이벤트",
                    style: TextStyle(
                      color:
                          ischeckedbutton[0] ? Colors.blue[300] : Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                  style: ButtonStyle(side:
                      MaterialStateProperty.resolveWith<BorderSide>(
                          (Set<MaterialState> states) {
                    final Color color =
                        ischeckedbutton[1] ? Colors.blue : Colors.grey;
                    return BorderSide(color: color, width: 2);
                  })),
                  onPressed: () {
                    setState(() {
                      ischeckedbutton[1] = ischeckedbutton[1] ? false : true;
                    });
                  },
                  child: Text(
                    "동행 찾기",
                    style: TextStyle(
                      color:
                          ischeckedbutton[1] ? Colors.blue[300] : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CheckboxRow(
                    value1: _isChecked1,
                    onChanged1: (bool value) {
                      setState(() {
                        _isChecked1 = value;
                      });
                    },
                    value2: _isChecked2,
                    onChanged2: (bool value) {
                      setState(() {
                        _isChecked2 = value;
                      });
                    }),
                CheckBoxWidget(
                    isChecked1: _isChecked1, isChecked2: _isChecked2),
                DateTimePickerCol(chosenDateTime1)
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
