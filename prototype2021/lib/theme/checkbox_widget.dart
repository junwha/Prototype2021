import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  bool isChecked1 = false;
  bool isChecked2 = false;
  CheckBoxWidget(bool isChecked1, bool isChecked2) {
    this.isChecked1 = isChecked1;
    this.isChecked2 = isChecked2;
  }

  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  final _valueList1 = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  final _valueList2 = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  final _valueList3 = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  var _selectedValue1 = '0';
  var _selectedValue2 = '0';
  var _selectedValue3 = '0';

  @override
  Widget build(BuildContext context) {
    if (this.widget.isChecked1 && this.widget.isChecked2) {
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
                    onChanged: (String? value) {
                      setState(() {
                        _selectedValue1 = value == null ? "" : value;
                      });
                    },
                  ),
                  Text("명")
                ],
              ),
            ],
          ),
        ],
      );
    } else if (this.widget.isChecked1) {
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
                  onChanged: (String? value) {
                    setState(() {
                      _selectedValue1 = value == null ? "" : value;
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
                onChanged: (String? value) {
                  setState(() {
                    _selectedValue2 = value == null ? "" : value;
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
                onChanged: (String? value) {
                  setState(() {
                    _selectedValue3 = value == null ? "" : value;
                  });
                },
              ),
              Text("살")
            ],
          ),
        ],
      );
    } else if (this.widget.isChecked2) {
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
                  onChanged: (String? value) {
                    setState(() {
                      _selectedValue1 = value == null ? "" : value;
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
                onChanged: (String? value) {
                  setState(() {
                    _selectedValue2 = value == null ? "" : value;
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
                onChanged: (String? value) {
                  setState(() {
                    _selectedValue3 = value == null ? "" : value;
                  });
                },
              ),
              Text("명")
            ],
          ),
        ],
      );
    } else {
      return Text("");
    }
  }
}
