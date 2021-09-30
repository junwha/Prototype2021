import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';

class SelectableTextButton extends StatefulWidget {
  String titleName;
  bool isChecked;
  Function()? onPressed;
  EdgeInsets padding;

  SelectableTextButton(
      {required this.titleName,
      required this.isChecked,
      this.onPressed,
      this.padding = const EdgeInsets.all(0)});

  @override
  _SelectableTextButtonState createState() => _SelectableTextButtonState();
}

class _SelectableTextButtonState extends State<SelectableTextButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: this.widget.padding,
      child: OutlinedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
            side: MaterialStateProperty.resolveWith<BorderSide>(
                (Set<MaterialState> states) {
              return BorderSide(
                  color: this.widget.isChecked
                      ? Color(0xffbbd2ff)
                      : Color(0xffdbdbdb),
                  width: 2);
            })),
        onPressed: this.widget.onPressed,
        child: Text(
          this.widget.titleName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12 * pt,
            color:
                this.widget.isChecked ? Color(0xff4080ff) : Color(0xffdbdbdb),
          ),
        ),
      ),
    );
  }
}
