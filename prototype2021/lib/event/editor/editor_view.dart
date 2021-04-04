import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';

class EditorView extends StatefulWidget {
  @override
  _EditorViewState createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  var _isChecked1 = false;
  var _isChecked2 = false;
  final _valueList1 = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  final _valueList2 = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  final _valueList3 = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  var _selectedValue1 = '0';
  var _selectedValue2 = '0';
  var _selectedValue3 = '0';

  String resultString;
  DateTime _chosenDateTime;

  void _showDatePicker(ctx) {
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
                            _chosenDateTime = val;
                          });
                        }),
                  ),

                  // Close the modal
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
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ko', 'KO'),
          const Locale('en', 'US'),
        ],
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
                Container(height: 1, width: 500, color: Colors.grey),
                TextField(
                    decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Hint',
                )),
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
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14)),
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
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14)),
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
                ),
              ],
            ),
          ),
        ));
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
                    value: _selectedValue1,
                    items: _valueList1.map(
                      (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedValue1 = value;
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
                onPressed: () => _showDatePicker(context),
              ),
            ],
          ),
          Text(_chosenDateTime != null ? _chosenDateTime.toString() : '선택안함'),
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
                onPressed: () => _showDatePicker(context),
              ),
            ],
          ),
          Text(_chosenDateTime != null ? _chosenDateTime.toString() : '선택안함'),
        ],
      );
    } else if (_isChecked1) {
      return Column(
        children: [
          Row(children: [
            Text("모집인원"),
            SizedBox(
              width: 50,
            ),
            Row(
              children: [
                DropdownButton(
                  value: _selectedValue1,
                  items: _valueList1.map(
                    (value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue1 = value;
                    });
                  },
                ),
                Text("명")
              ],
            ),
          ]),
          Row(
            children: [
              Text("나이"),
              SizedBox(
                width: 80,
              ),
              DropdownButton(
                value: _selectedValue2,
                items: _valueList2.map(
                  (value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedValue2 = value;
                  });
                },
              ),
              Text("    ~    "),
              DropdownButton(
                value: _selectedValue3,
                items: _valueList3.map(
                  (value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedValue3 = value;
                  });
                },
              ),
              Text("살")
            ],
          ),
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
                onPressed: () => _showDatePicker(context),
              ),
            ],
          ),
          Text(_chosenDateTime != null ? _chosenDateTime.toString() : '선택안함'),
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
                onPressed: () => _showDatePicker(context),
              ),
            ],
          ),
          Text(_chosenDateTime != null ? _chosenDateTime.toString() : '선택안함'),
        ],
      );
    } else if (_isChecked2) {
      return Column(
        children: [
          Row(children: [
            Text("모집인원"),
            SizedBox(
              width: 50,
            ),
            Row(
              children: [
                DropdownButton(
                  value: _selectedValue1,
                  items: _valueList1.map(
                    (value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue1 = value;
                    });
                  },
                ),
                Text("명")
              ],
            ),
          ]),
          Row(
            children: [
              Text("모집인원"),
              SizedBox(
                width: 40,
              ),
              Text("남"),
              SizedBox(
                width: 10,
              ),
              DropdownButton(
                value: _selectedValue2,
                items: _valueList2.map(
                  (value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedValue2 = value;
                  });
                },
              ),
              Text("명"),
              SizedBox(
                width: 10,
              ),
              Text("여"),
              SizedBox(
                width: 10,
              ),
              DropdownButton(
                value: _selectedValue3,
                items: _valueList3.map(
                  (value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedValue3 = value;
                  });
                },
              ),
              Text("명")
            ],
          ),
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
                onPressed: () => _showDatePicker(context),
              ),
            ],
          ),
          Text(_chosenDateTime != null ? _chosenDateTime.toString() : '선택안함'),
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
                onPressed: () => _showDatePicker(context),
              ),
            ],
          ),
          Text(_chosenDateTime != null ? _chosenDateTime.toString() : '선택안함'),
        ],
      );
    } else {
      return Text("");
    }
  }
}
