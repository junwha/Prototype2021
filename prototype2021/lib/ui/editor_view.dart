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
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  List<bool> ischeckedbutton = [false, false];
  DateTime? chosenDateTime1;
  DateTime? chosenDateTime2;

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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  CloseButton(
                    color: Colors.black,
                    onPressed: () {},
                  ),
                  Text(
                    '글 쓰기',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey, // background
                      onPrimary: Colors.black, // foreground
                    ),
                    onPressed: () {},
                    child: Text('임시저장',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {},
                    child: Text('등록',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ]),
            SizedBox(
              height: 25,
            ),
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
            SizedBox(
              height: 10,
            ),
            Container(height: 1, width: 500, color: Colors.grey),
            TextField(
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: '제목'),
            ),
            Container(height: 1, width: 500, color: Colors.grey),
            Container(
              alignment: FractionalOffset.topLeft,
              height: 200,
              width: 500,
              color: Colors.white,
              child: TextField(
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: '내용'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
            Column(
              children: [
                CheckboxRow(
                    value1: _isChecked1,
                    onChanged1: (bool? value) {
                      setState(() {
                        _isChecked1 = value == null ? false : value;
                      });
                    },
                    value2: _isChecked2,
                    onChanged2: (bool? value) {
                      setState(() {
                        _isChecked2 = value == null ? false : value;
                      });
                    }),
                CheckBoxWidget(_isChecked1, _isChecked2),
                //   DateTimePickerCol(chosenDateTime1) TODO: implement DateTimePicker
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
