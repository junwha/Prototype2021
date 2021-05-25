import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';

class SelectableTextButton extends StatefulWidget {
  String titleName;
  bool isChecked;
  Function()? onPressed;

  SelectableTextButton(
      {required this.titleName, required this.isChecked, this.onPressed});

  @override
  _SelectableTextButtonState createState() => _SelectableTextButtonState();
}

class _SelectableTextButtonState extends State<SelectableTextButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(side: MaterialStateProperty.resolveWith<BorderSide>(
          (Set<MaterialState> states) {
        final Color color = this.widget.isChecked ? Colors.blue : Colors.grey;
        return BorderSide(color: color, width: 2);
      })),
      onPressed: this.widget.onPressed,
      child: Text(
        this.widget.titleName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12 * pt,
          color: this.widget.isChecked ? Colors.blue[300] : Colors.grey,
        ),
      ),
    );
  }
}
