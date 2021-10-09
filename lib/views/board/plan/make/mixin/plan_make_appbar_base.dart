import 'package:flutter/material.dart';

mixin PlanMakeAppBarBase {
  AppBar buildAppBar(
    BuildContext context, {
    required void Function() navigator,
    Color? backgroundColor,
    double? elevation,
  }) {
    return AppBar(
      elevation: elevation ?? 0,
      backgroundColor: backgroundColor ?? Colors.transparent,
      shadowColor: const Color(0xfff6f6f6),
      leading: IconButton(
          onPressed: navigator,
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
