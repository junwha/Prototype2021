import 'package:flutter/material.dart';

class TBSaveButton extends StatefulWidget {
  String buttonTitle;

  TBSaveButton({required this.buttonTitle});

  @override
  _TBSaveButtonState createState() => _TBSaveButtonState();
}

class _TBSaveButtonState extends State<TBSaveButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Container(
        height: 40,
        width: 140,
        child: Center(
          child: Text(this.widget.buttonTitle,
              style: TextStyle(
                fontSize: 17,
                color: Color(0xff555555),
                fontWeight: FontWeight.w700,
              )),
        ),
        decoration: BoxDecoration(
          color: Color(0xfff6f6f6),
          borderRadius: BorderRadius.circular(11),
          boxShadow: [
            BoxShadow(
              color: Color(0x29000000),
              offset: Offset(3, 3),
              blurRadius: 3,
              spreadRadius: 0,
            ),
          ],
        ),
      ),
    );
  }
}
