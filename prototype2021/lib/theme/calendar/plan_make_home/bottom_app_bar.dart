import 'package:flutter/material.dart';
import 'package:prototype2021/theme/pop_up.dart';

mixin PlanMakeHomeBottomAppBarMixin {
  Container buildSaveButton() {
    return buildBottomRoundedButton([
      Text("저장하기",
          style: const TextStyle(
              color: const Color(0xff555555),
              fontWeight: FontWeight.w700,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 17.0),
          textAlign: TextAlign.center)
    ]);
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

  Container buildBottomRoundedButton(List<Widget> children,
      [void Function()? onTap]) {
    return Container(
      child: InkWell(
        onTap: onTap,
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
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: 50,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}
