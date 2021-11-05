import 'package:flutter/material.dart';

/*
 * It's width must be 350
 */
class TBRadioBar extends StatefulWidget {
  int selectedRadio = 0;
  Function(int?) onChanged;
  String minimumText;
  String maximumText;
  TBRadioBar(
      {required this.selectedRadio,
      required this.onChanged,
      required this.minimumText,
      required this.maximumText});

  @override
  _TBRadioBarState createState() => _TBRadioBarState();
}

class _TBRadioBarState extends State<TBRadioBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width - 100,
              color: Color(0xffbdbdbd),
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.max,
              alignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildRadio(context, 1),
                buildRadio(context, 2),
                buildRadio(context, 3),
                buildRadio(context, 4),
                buildRadio(context, 5),
              ],
            ),
          ],
        ),
        buildRadioButtonTextArea(
            this.widget.minimumText, this.widget.maximumText),
      ],
    );
  }

  Row buildRadioButtonTextArea(String minimumText, String maximumText) {
    TextStyle buttonTextStyle = const TextStyle(
        fontSize: 14, color: Color(0xff707070), fontWeight: FontWeight.w400);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          minimumText,
          style: buttonTextStyle,
        ),
        Text(
          maximumText,
          style: buttonTextStyle,
          textAlign: TextAlign.right,
        )
      ],
    );
  }

  Widget buildRadio(BuildContext context, int value) {
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
