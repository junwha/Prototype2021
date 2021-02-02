import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _valueList = ['0', '1', '2', '3', '4', '5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.greenAccent[100], width: 3),
            color: Colors.greenAccent[100]),
        width: 320,
        height: 300,
        child: Column(children: [
          _buildSelectMenuBar(
            Icon(Icons.access_time_rounded, size: 30),
            "아침 전",
            _valueList[0],
          ),
          SizedBox(height: 8),
          Container(height: 1, width: 320, color: Colors.white),
          _buildSelectMenuBar(
            Icon(Icons.access_time_rounded, size: 30),
            "아침과 점심 사이",
            _valueList[0],
          ),
          SizedBox(height: 8),
          Container(height: 1, width: 320, color: Colors.white),
          _buildSelectMenuBar(
            Icon(Icons.access_time_rounded, size: 30),
            "점심과 점심 사이",
            _valueList[0],
          ),
          SizedBox(height: 8),
          Container(height: 1, width: 320, color: Colors.white),
          _buildSelectMenuBar(
            Icon(Icons.access_time_rounded, size: 30),
            "저녁 이후",
            _valueList[0],
          ),
        ]),
      ),
    );
  }

  Padding _buildSelectMenuBar(Icon icon, String text, String _value) {
    var _selectedValue = _value;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icon,
          SizedBox(
            width: 1,
          ),
          Text(text,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Container(
            color: Colors.white,
            child: DropdownButton(
              iconEnabledColor: Colors.grey,
              focusColor: Colors.white,
              dropdownColor: Colors.white,
              value: _selectedValue,
              items: _valueList.map(
                (value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text('         ' + value + '      '),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
