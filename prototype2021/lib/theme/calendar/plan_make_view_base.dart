import 'package:flutter/material.dart';

class PlanMakeViewBase {
  AppBar buildAppBar(BuildContext context, [Color? backgroundColor]) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor ?? const Color(0xfff6f6f6),
      shadowColor: const Color(0xfff6f6f6),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset('assets/icons/ic_arrow_left_back.png')),
      toolbarHeight: 60,
      // actions: [
      //   IconButton(
      //       onPressed: () {},
      //       icon: Image.asset('assets/icons/ic_hamburger_menu.png'))
      // ],
    );
  }
}
