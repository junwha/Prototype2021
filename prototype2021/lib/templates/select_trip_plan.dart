import 'package:flutter/material.dart';

class SelectTripPlan extends StatefulWidget {
  @override
  _SelectTripPlanState createState() => _SelectTripPlanState();
}

class _SelectTripPlanState extends State<SelectTripPlan> {
  final _valueList = ['0', '1', '2', '3', '4', '5'];
  List<String> _selectedValue = ['0', '0', '0', '0'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.greenAccent[100], width: 3),
          color: Colors.greenAccent[100]),
      width: 320,
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
                            child: Text('         ' + value + '      ')),
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
