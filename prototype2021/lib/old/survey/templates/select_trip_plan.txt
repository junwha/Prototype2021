import 'package:flutter/material.dart';
import 'package:prototype2021/templates/borded_button.dart';

class SelectTripPlan extends StatefulWidget {
  @override
  _SelectTripPlanState createState() => _SelectTripPlanState();
}

class _SelectTripPlanState extends State<SelectTripPlan> {
  final _valueList = [0, 1, 2, 3, 4, 5];
  List<int> _selectedValue = [0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.greenAccent[100], width: 3),
              color: Colors.greenAccent[100]),
          height: 270,
          child: Column(children: [
            _buildSelectMenuBar(
              0,
              Icon(Icons.access_time_rounded, size: 30),
              "아침 전",
            ),
            SizedBox(height: 8),
            Container(height: 1, width: 320, color: Colors.white),
            _buildSelectMenuBar(
              1,
              Icon(Icons.access_time_rounded, size: 30),
              "아침과 점심 사이",
            ),
            SizedBox(height: 8),
            Container(height: 1, width: 320, color: Colors.white),
            _buildSelectMenuBar(
              2,
              Icon(Icons.access_time_rounded, size: 30),
              "점심과 저녁 사이",
            ),
            SizedBox(height: 8),
            Container(height: 1, width: 320, color: Colors.white),
            _buildSelectMenuBar(
              3,
              Icon(Icons.access_time_rounded, size: 30),
              "저녁 이후",
            ),
          ]),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                child: BordedButton(
                  child: Text("내 플랜 미리보기"),
                  onPressed: openDialog,
                  radius: 5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  openDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent[200],
                      border: Border.all(color: Colors.greenAccent[200]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      "여행 플랜",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: ListView.builder(
                        itemCount: 3 +
                            _selectedValue[0] +
                            _selectedValue[1] +
                            _selectedValue[2] +
                            _selectedValue[3],
                        itemBuilder: (BuildContext _context, int i) {
                          if (i < _selectedValue[0]) {
                            var idx = i + 1;
                            return _buildPlanRow(
                                i + 1, "여행지 $idx", Icons.location_on_outlined);
                          } else if (i == _selectedValue[0]) {
                            return _buildPlanRow(i + 1, "아침", Icons.restaurant);
                          } else if (i <
                              _selectedValue[0] + _selectedValue[1] + 1) {
                            var idx = i;
                            return _buildPlanRow(
                                i + 1, "여행지 $idx", Icons.location_on_outlined);
                          } else if (i ==
                              _selectedValue[0] + _selectedValue[1] + 1) {
                            return _buildPlanRow(i + 1, "점심", Icons.restaurant);
                          } else if (i <
                              _selectedValue[0] +
                                  _selectedValue[1] +
                                  _selectedValue[2] +
                                  2) {
                            var idx = i - 1;
                            return _buildPlanRow(
                                i + 1, "여행지 $idx", Icons.location_on_outlined);
                          } else if (i ==
                              _selectedValue[0] +
                                  _selectedValue[1] +
                                  _selectedValue[2] +
                                  2) {
                            return _buildPlanRow(i + 1, "저녁", Icons.restaurant);
                          } else {
                            var idx = i - 2;
                            return _buildPlanRow(
                                i + 1, "여행지 $idx", Icons.location_on_outlined);
                          }
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: double.maxFinite,
                      height: 60,
                      child: FlatButton(
                        child: Text("닫기"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildPlanRow(int i, String text, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (i == 1)
            ? SizedBox()
            : Container(
                margin: EdgeInsets.only(left: 15),
                height: 8,
                width: 1,
                color: Colors.black),
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey)),
              child: Center(
                child: Text("$i"),
              ),
            ),
            SizedBox(width: 5),
            Icon(
              icon,
              size: 35,
            ),
            SizedBox(width: 5),
            Text(text),
          ],
        ),
        (i ==
                3 +
                    _selectedValue[0] +
                    _selectedValue[1] +
                    _selectedValue[2] +
                    _selectedValue[3])
            ? SizedBox()
            : Container(
                margin: EdgeInsets.only(left: 15),
                height: 8,
                width: 1,
                color: Colors.black),
      ],
    );
  }

  Widget _buildSelectMenuBar(int i, Icon icon, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              SizedBox(
                width: 4,
              ),
              Text(text,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(1, 3), // changes position of shadow
                ),
              ],
            ),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              child: SizedBox(
                height: 40,
                child: DropdownButton(
                  underline: SizedBox(),
                  focusColor: Colors.white,
                  dropdownColor: Colors.white,
                  value: _selectedValue[i],
                  items: _valueList.map(
                    (value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Container(
                            color: Colors.white,
                            child: Text('         $value      ')),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue[i] = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
