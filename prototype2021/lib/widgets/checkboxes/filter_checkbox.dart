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
            height: 24,
            width: 24,
            decoration: BoxDecoration(
                color:
                    this.widget.isChecked ? Colors.blue : CupertinoColors.white,
                border: Border.all(
                    color: CupertinoColors.systemGrey,
                    style: BorderStyle.solid,
                    width: 1),
                borderRadius: BorderRadius.all(Radius.circular(2))),
            child: this.widget.isChecked
                ? Image.asset('assets/icons/ic_filter_check_white.png')
                : Image.asset('assets/icons/ic_filter_check_gray.png')),
        onPressed: () {
          setState(() {
            this.widget.isChecked = !this.widget.isChecked;
          });
        });
  }
}
