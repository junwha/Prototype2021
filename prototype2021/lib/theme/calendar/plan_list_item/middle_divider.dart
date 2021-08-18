import 'package:flutter/material.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/helper.dart';
import 'package:prototype2021/theme/calendar/plan_make_home.dart';
import 'package:prototype2021/theme/calendar/plan_make_home/constants.dart';

class PlanListMiddleDivider extends StatelessWidget with PlanListItemHelper {
  final num? distance;
  final Key? key;

  PlanListMiddleDivider({required this.distance, this.key});

  @override
  Widget build(BuildContext context) {
    PlanMakeHomeState? grandParent =
        context.findAncestorStateOfType<PlanMakeHomeState>();
    PlanMakeMode mode = grandParent?.mode ?? PlanMakeMode.add;
    bool onDrag = grandParent?.onDrag ?? false;
    switch (mode) {
      case PlanMakeMode.add:
        return distance is num ? buildDistanceIcon() : buildPlaceholder();
      case PlanMakeMode.edit:
        return buildPasteIcon(onDrag);
      default:
        return buildPlaceholder();
    }
  }

  SizedBox buildPlaceholder() {
    return SizedBox(
      key: key,
      height: 27,
    );
  }

  SizedBox buildPasteIcon(bool onDrag) {
    return SizedBox(
      key: key,
      height: 27,
      child: Center(
        child: TextButton(
          onPressed: onDrag ? null : () {},
          child: Text(onDrag ? "" : "붙여넣기",
              style: const TextStyle(
                  color: const Color(0xff707070),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 9.0),
              textAlign: TextAlign.center),
        ),
      ),
    );
  }

  SizedBox buildDistanceIcon() {
    return SizedBox(
      key: key,
      height: 27,
      child: Stack(children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: Text(distanceWithUnit(distance as num),
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
