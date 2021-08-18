import 'package:flutter/material.dart';
import 'package:prototype2021/theme/pop_up.dart';

mixin PlanMakeHomeAIDialogMixin {
  TBLargeDialog buildAIDialog(BuildContext context) {
    return TBLargeDialog(
        title: "AI 추천",
        body: Center(
          child: Column(
            children: [
              buildAIDialogButton("자동 플랜 설계", true, () {}),
              buildAIDialogButton("일정 순서 조정", true, () {}),
              buildAIDialogButton("다음 여행지 추천", false, () {}),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ));
  }

  InkWell buildAIDialogButton(
      String dialog, bool isPaid, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Container(
          child: Stack(
            children: [
              Positioned.fill(
                  child: Align(
                      child: Text(dialog,
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0),
                          textAlign: TextAlign.center),
                      alignment: Alignment.center)),
              Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: isPaid
                        ? Image.asset('assets/icons/ic_calender_star_paid.png')
                        : SizedBox(),
                  ),
                  top: -20,
                  right:
                      -120) // This should be fixed in near future, to have a position relative to the text above
            ],
          ),
          height: 80,
          alignment: Alignment.center,
          clipBehavior: Clip.none,
        ),
        alignment: Alignment.center,
        // padding: EdgeInsets.symmetric(vertical: 27),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0, color: const Color(0xffe6e6e6))),
            color: Colors.white),
        clipBehavior: Clip.none,
      ),
    );
  }
}
