import 'package:flutter/material.dart';

class TBDistanceIcon extends StatelessWidget {
  num distance;
  TBDistanceIcon({required this.distance, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: key,
      height: 27,
      child: Stack(children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: Text(distanceWithUnit(this.distance),
                  style: const TextStyle(
                      color: const Color(0xff4080ff),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 11.0),
                  textAlign: TextAlign.center),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  border: Border.all(color: const Color(0xffbbd2ff), width: 1),
                  color: const Color(0xffffffff)),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
          ),
          top: -5,
        )
      ], clipBehavior: Clip.none),
    );
  }

  String distanceWithUnit(num distance) {
    if (distance < 1000) {
      return "${distance.toStringAsFixed(0)}m";
    } else {
      String distanceInKm = (distance / 1000).toStringAsFixed(1);
      return "${distanceInKm}km";
    }
  }
}
