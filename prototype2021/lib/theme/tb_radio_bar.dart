import 'package:flutter/material.dart';

class TBRadioBar extends StatefulWidget {
  int selectedRadio = 0;
  Function(int?) onChanged;

  TBRadioBar({required this.selectedRadio, required this.onChanged});

  @override
  _TBRadioBarState createState() => _TBRadioBarState();
}

class _TBRadioBarState extends State<TBRadioBar> {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      mainAxisSize: MainAxisSize.max,
      alignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buildRadio(context, 1),
        buildRadio(context, 2),
        buildRadio(context, 3),
        buildRadio(context, 4),
        buildRadio(context, 5),
      ],
    );
  }

  Container buildRadio(BuildContext context, int value) {
    return Container(
      width: 30,
      height: 30,
      color: Colors.white,
      child: Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: const Color(0xffbdbdbd),
          disabledColor: Colors.blue,
          backgroundColor: Colors.white,
        ),
        child: Transform.scale(
          scale: 1.7,
          child: Radio(
            focusColor: Colors.white,
            hoverColor: Colors.white,
            value: value,
            groupValue: this.widget.selectedRadio,
            activeColor: Colors.blue,
            onChanged: this.widget.onChanged,
          ),
        ),
      ),
    );
  }
}
