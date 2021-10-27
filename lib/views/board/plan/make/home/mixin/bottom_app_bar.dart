import 'package:flutter/material.dart';
import 'package:prototype2021/views/board/plan/make/home/plan_make_home_view.dart';
import 'package:prototype2021/widgets/dialogs/pop_up.dart';
import 'dart:io' show Platform;

mixin PlanMakeHomeBottomAppBarMixin on State<PlanMakeHomeView> {
  Container buildSaveButton(void Function() onTap) {
    return buildBottomRoundedButton(
      [
        Text("저장하기",
            style: const TextStyle(
                color: const Color(0xff555555),
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 17.0),
            textAlign: TextAlign.center)
      ],
      onTap,
    );
  }

  Container buildAIButton(BuildContext context, TBLargeDialog aiDialog) {
    return buildBottomRoundedButton([
      Image.asset(
        'assets/icons/img_ai_big.png',
        fit: BoxFit.contain,
      ),
      SizedBox(
        width: 26,
      ),
      Text("AI 추천",
          style: const TextStyle(
              color: const Color(0xff555555),
              fontWeight: FontWeight.w700,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 17.0),
          textAlign: TextAlign.center)
    ], () {
      showDialog(context: context, builder: (context) => aiDialog);
    });
  }

  InkWell buildResetButton([void Function()? onTap]) {
    return buildBottomFilledButton("초기화", const Color(0xff5890ff), onTap);
  }

  InkWell buildEditDoneButton([void Function()? onTap]) {
    return buildBottomFilledButton("편집완료", const Color(0xff4080ff), onTap);
  }

  InkWell buildBottomFilledButton(String title, Color backgroundColor,
      [void Function()? onTap]) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: SafeArea(
            child: Container(
          alignment: Alignment.center,
          child: Text(title,
              style: const TextStyle(
                  color: const Color(0xffdde9ff),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0),
              textAlign: TextAlign.center),
          height: 70,
        )),
        decoration: BoxDecoration(color: backgroundColor),
      ),
    );
  }

  Container buildBottomRoundedButton(List<Widget> children,
      [void Function()? onTap]) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: SafeArea(
          child: Container(
            child: Row(
              children: children,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(11)),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(3, 3),
                      blurRadius: 3,
                      spreadRadius: 0)
                ],
                color: const Color(0xfff6f6f6)),
            height: 50,
          ),
        ),
      ),
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
    );
  }
}
