import 'package:flutter/material.dart';

class EditorView extends StatefulWidget {
  @override
  _EditorViewState createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  @override
  Widget build(BuildContext context) {
    var _isChecked1 = false;
    var _isChecked2 = false;

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
                          onChanged: (value) {
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
                          onChanged: (value) {
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
    final _valueList = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
    var _selectedValue = '0';

    if (_isChecked1 && _isChecked2) {
      return Column(
        children: [
          Row(
            children: [
              Text("모집인원"),
            ],
          ),
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
          )
        ],
      );
    } else if (_isChecked1) {
      return Text("메롱");
    } else if (_isChecked2) {
      return Text("g하,,..언제끝나냐");
    } else {
      return Text("망했따");
    }
  }
}
