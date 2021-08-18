import 'package:flutter/material.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/helper.dart';
import 'package:prototype2021/theme/calendar/plan_make_home.dart';
import 'package:prototype2021/theme/calendar/plan_make_home/constants.dart';

class PlanListMiddleDivider extends StatelessWidget with PlanListItemHelper {
  final num distance;

  PlanListMiddleDivider({required this.distance});

  @override
  Widget build(BuildContext context) {
    PlanMakeHomeState? grandParent =
        context.findAncestorStateOfType<PlanMakeHomeState>();
    PlanMakeMode mode = grandParent?.mode ?? PlanMakeMode.add;
    switch (mode) {
      case PlanMakeMode.add:
        return buildDistanceIcon();
      case PlanMakeMode.edit:
        return buildPasteIcon();
      default:
        return buildPlaceholder();
    }
  }

  SizedBox buildPlaceholder() {
    return SizedBox(
      height: 27,
    );
  }

  SizedBox buildPasteIcon() {
    return SizedBox(
      height: 27,
      child: Center(
        child: Text("붙여넣기",
            style: const TextStyle(
                color: const Color(0xff707070),
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 9.0),
            textAlign: TextAlign.center),
      ),
    );
  }

  SizedBox buildDistanceIcon() {
    return SizedBox(
      height: 27,
      child: Stack(children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: Text(distanceWithUnit(distance),
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
}
