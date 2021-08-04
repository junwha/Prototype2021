import 'package:flutter/material.dart';

class TBPlusMinusButton extends StatefulWidget {
  int selectedRadio = 0;
  int _counter = 0;
  bool pluscolor = true;
  bool minuscolor = true;
  final List<String> planList = [
    '당일치기',
    '2일',
    '3일',
    '4일',
    '5일',
    '6일',
    '7일~14일',
    '15일이상'
  ];
  List<String> stringList;

  TBPlusMinusButton({required this.stringList});

  @override
  _TBPlusMinusButtonState createState() => _TBPlusMinusButtonState();
}

class _TBPlusMinusButtonState extends State<TBPlusMinusButton> {
  void _incrementCounter() {
    setState(() {
      if (this.widget._counter != this.widget.stringList.length - 1) {
        this.widget._counter++;
        if (this.widget._counter == this.widget.stringList.length - 1) {
          this.widget.pluscolor = false;
        } else {
          this.widget.pluscolor = true;
          this.widget.minuscolor = true;
        }
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (this.widget._counter != 0) {
        this.widget._counter--;
        if (this.widget._counter == 0) {
          this.widget.minuscolor = false;
        } else {
          this.widget.pluscolor = true;
          this.widget.minuscolor = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FloatingActionButton(
            mini: true,
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: _decrementCounter,
            child: this.widget.minuscolor
                ? Image.asset('assets/icons/button_filter_minus_black.png')
                : Image.asset('assets/icons/button_filter_minus_gray.png')),
        SizedBox(
          width: 20,
        ),
        Container(
          width: 65,
          child: Center(
            child: Text(
              this.widget.stringList[this.widget._counter],
              style: const TextStyle(
                  color: const Color(0xff707070),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        FloatingActionButton(
            mini: true,
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: _incrementCounter,
            child: this.widget.pluscolor
                ? Image.asset('assets/icons/button_filter_plus_black.png')
                : Image.asset('assets/icons/button_filter_plus_gray.png')),
      ],
    );
  }
}
