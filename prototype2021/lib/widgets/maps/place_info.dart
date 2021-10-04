import 'package:flutter/material.dart';

class PlaceInfo extends StatefulWidget {
  @override
  _PlaceInfoState createState() => _PlaceInfoState();
}

class _PlaceInfoState extends State<PlaceInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          color: Colors.white,
          width: double.maxFinite,
          height: 0,
          child: Column(
            children: [
              Text("이 장소가 언급된 글"),
            ],
          ),
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        ),
      ],
    );
  }
}
