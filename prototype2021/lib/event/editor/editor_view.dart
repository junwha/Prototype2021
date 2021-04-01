import 'package:flutter/material.dart';

class EditorView extends StatefulWidget {
  @override
  _EditorViewState createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  var _isChecked1 = false;
  var _isChecked2 = false;
  final _valueList = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  var _selectedValue = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MINAMONA"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(height: 1, width: 500, color: Colors.grey),
            Text("제목",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
            Container(height: 1, width: 500, color: Colors.grey),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("이벤트 정보",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Row(
                      children: [
                        Text("성별무관",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14)),
                        Checkbox(
                          value: _isChecked1,
                          onChanged: (bool value) {
                            setState(() {
                              _isChecked1 = value;
                            });
                          },
                        ),
                        Text("나이무관",
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14)),
                        Checkbox(
                          value: _isChecked2,
                          onChanged: (bool value) {
                            setState(() {
                              _isChecked2 = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                _buildUI(_isChecked1, _isChecked2),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUI(bool _isChecked1, bool _isChecked2) {
    if (_isChecked1 && _isChecked2) {
      return Column(
        children: [
          Row(
            children: [
              Text("모집인원"),
              SizedBox(
                width: 50,
              ),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedValue,
                    items: _valueList.map(
                      (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                  ),
                  Text("명")
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text("여행시작일"),
              SizedBox(
                width: 40,
              ),
              Text("선택안함")
            ],
          ),
          Row(
            children: [
              Text("여행종료일"),
              SizedBox(
                width: 40,
              ),
              Text("선택안함")
            ],
          )
        ],
      );
    } else if (_isChecked1) {
      return Text("");
    } else if (_isChecked2) {
      return Text("");
    } else {
      return Text("");
    }
  }
}
