import 'package:flutter/material.dart';
import 'package:prototype2021/views/board/plan/make/list_item/plan_list_item.dart';
import 'package:prototype2021/views/board/plan/make/home/mixin/constants.dart';

mixin PlanListItemSubHeaderMixin on State<PlanListItem> {
  SizedBox buildScheduleCardsSubHeader(
      PlanMakeMode mode, bool hasItem, bool onDrag, void Function() pasteData) {
    return !hasItem && mode == PlanMakeMode.edit
        ? SizedBox(
            height: 27,
            child: Center(
              child: TextButton(
                onPressed: onDrag ? null : pasteData,
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
          )
        : SizedBox();
  }
}
