import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';

class ContentTag extends StatelessWidget {
  String tagName;
  LinearGradient? background;
  Color? textColor;

  ContentTag({required this.tagName, this.background, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8 * pt, vertical: 2 * pt),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: background ??
              LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(107, 214, 230, 1.0),
                  Color.fromRGBO(42, 190, 252, 1.0),
                ],
              ),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Text(
          tagName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11 * pt,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ));
  }
}
