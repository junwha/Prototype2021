import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FilterCheckBox extends StatefulWidget {
  bool isChecked;

  FilterCheckBox({required this.isChecked});

  @override
  _FilterCheckBoxState createState() => _FilterCheckBoxState();
}

class _FilterCheckBoxState extends State<FilterCheckBox> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        child: Container(
          decoration: BoxDecoration(
              color:
                  this.widget.isChecked ? Colors.blue : CupertinoColors.white,
              border: Border.all(
                  color: CupertinoColors.systemGrey,
                  style: BorderStyle.solid,
                  width: 1),
              borderRadius: BorderRadius.all(Radius.circular(2))),
          child: Icon(CupertinoIcons.check_mark,
              size: 20,
              color: this.widget.isChecked
                  ? CupertinoColors.white
                  : CupertinoColors.systemGrey),
        ),
        onPressed: () {
          setState(() {
            this.widget.isChecked = !this.widget.isChecked;
          });
        });
  }
}
