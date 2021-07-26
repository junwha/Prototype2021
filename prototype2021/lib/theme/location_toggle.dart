import 'package:flutter/material.dart';
import 'package:prototype2021/data/location_data.dart';
import 'package:prototype2021/settings/constants.dart';

class LocationToggle extends StatefulWidget {
  const LocationToggle({Key? key}) : super(key: key);

  @override
  _LocationToggleState createState() => _LocationToggleState();
}

class _LocationToggleState extends State<LocationToggle> {
  String mainLocation = "서울특별시";
  String subLocation = "";
  @override
  Widget build(BuildContext context) {
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
                    },
                        data == mainLocation
                            ? Color(0xffe8e8e8)
                            : Color(0xffffffff)))
                .toList(),
          ),
        ),
        Expanded(
          flex: 10,
          child: ListView(
            children: subLocations[mainLocation]!
                .map((data) => buildOutlinedButton(data, () {
                      setState(() {
                        subLocation = data;
                      });
                    },
                        data == subLocation
                            ? Color(0xffe8e8e8)
                            : Color(0xffffffff)))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildOutlinedButton(String text, Function() onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
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
