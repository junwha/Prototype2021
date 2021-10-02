import 'package:flutter/material.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/contants.dart';
import 'package:prototype2021/ui/plan_make_home_view.dart';
import 'package:prototype2021/theme/calendar/plan_make_home/constants.dart';
import 'dart:io' show Platform;

mixin PlanMakeHomeMainMixin on State<PlanMakeHomeView> {
  Container buildTopShadowHidingContainer(Color blindContainerColor) {
    return Container(
      child: Stack(children: [
        Positioned.fill(
          child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 10,
                decoration: BoxDecoration(color: blindContainerColor),
              )),
          top: -60, // Blind Container height + planListItemsHeaderHeight
        )
      ], clipBehavior: Clip.none),
      height: 10,
    );
  }

  Container buildPlanListItemsHeader(
      PlanMakeMode mode,
      void Function(PlanMakeMode) setMode,
      double elevation,
      Animation<double> sizeAnimation,
      Color borderColor) {
    return Container(
      child: PhysicalModel(
        color: const Color(0x29000000).withOpacity(0.1),
        elevation: elevation,
        child: SizeTransition(
          sizeFactor: sizeAnimation,
          axisAlignment: 1.0,
          child: Container(
            child: Container(
              child: Row(
                children: [
                  buildPlanListItemsHeaderLeading(),
                  buildPlanListItemsHeaderActions(mode, setMode)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              padding:
                  EdgeInsets.only(right: 10, left: 13, bottom: 14, top: 14),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: borderColor, width: 0.5))),
            ),
            padding: EdgeInsets.symmetric(horizontal: PlanListItemPadding),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 50,
          ),
        ),
      ),
    );
  }

  Text buildPlanListItemsHeaderLeading() {
    return Text("일정",
        style: const TextStyle(
            color: const Color(0xff000000),
            fontWeight: FontWeight.w700,
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontSize: 14.0),
        textAlign: TextAlign.left);
  }

  GestureDetector buildPlanListItemsHeaderActions(
      PlanMakeMode mode, void Function(PlanMakeMode) setMode) {
    void _onTap() {
      switch (mode) {
        case PlanMakeMode.add:
          setMode(PlanMakeMode.edit);
          break;
        case PlanMakeMode.edit:
          setMode(PlanMakeMode.delete);
          break;
        case PlanMakeMode.delete:
          setMode(PlanMakeMode.edit);
          break;
        default:
          setMode(PlanMakeMode.add);
          break;
      }
    }

    return GestureDetector(
      onTap: _onTap,
      child: Opacity(
        opacity: 0.4,
        child: Container(
            child: Center(
              child: Text(mode == PlanMakeMode.edit ? "삭제" : "편집",
                  style: const TextStyle(
                      color: const Color(0x99707070),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 11.0),
                  textAlign: TextAlign.left),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                border: Border.all(color: const Color(0xff707070), width: 1),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(2, 2),
                      blurRadius: 2,
                      spreadRadius: 0)
                ],
                color: const Color(0xffffffff)),
            padding: EdgeInsets.symmetric(
                horizontal: 9, vertical: Platform.isAndroid ? 0 : 4),
            alignment: Alignment.topCenter),
      ),
    );
  }
}
