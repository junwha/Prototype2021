import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';

class TBEventMoreButton extends StatefulWidget {
  bool isAllList = false;
  TBEventMoreButton({required this.isAllList});

  @override
  _TBEventMoreButtonState createState() => _TBEventMoreButtonState();
}

class _TBEventMoreButtonState extends State<TBEventMoreButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Container(
            height: 35 * pt,
            width: 280 * pt,
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
                child: Text(
              "더보기",
              style: TextStyle(
                  fontSize: 15 * pt,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ))),
        onPressed: () {
          if (!this.widget.isAllList) {
            setState(() {
              this.widget.isAllList = true;
            });
          } else {
            // TODO: next page
          }
        });
  }
}
