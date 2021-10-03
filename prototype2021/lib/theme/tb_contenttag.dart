import 'package:flutter/material.dart';

class TBContentTag extends StatefulWidget {
  String contentTitle;

  TBContentTag({required this.contentTitle});

  @override
  _TBContentTagState createState() => _TBContentTagState();
}

class _TBContentTagState extends State<TBContentTag> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1)),
      child: Text(
        this.widget.contentTitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: const Color(0xff707070),
        ),
      ),
    );
  }
}
