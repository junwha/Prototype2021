import 'package:flutter/material.dart';
import 'package:prototype2021/data/location_data.dart';
import 'package:prototype2021/settings/constants.dart';

class LocationToggle extends StatefulWidget {
  const LocationToggle({Key? key}) : super(key: key);

  @override
  _LocationToggleState createState() => _LocationToggleState();
}

class _LocationToggleState extends State<LocationToggle> {
  @override
  Widget build(BuildContext context) {
    String mainLocation = "서울특별시";
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: ListView(
            children: mainLocations
                .map((data) => buildOutlinedButton(data, () {
                      setState(() {
                        mainLocation = data;
                      });
                    }))
                .toList(),
          ),
        ),
        Expanded(
          flex: 10,
          child: ListView(
            children: subLocations[mainLocation]!
                .map((data) => buildOutlinedButton(data, () {}))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildOutlinedButton(String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffe8e8e8),
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        height: 50 * pt,
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xff444444),
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
