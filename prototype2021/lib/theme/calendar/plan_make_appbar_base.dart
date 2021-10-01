import 'package:flutter/material.dart';
import 'package:prototype2021/ui/board/board_main_view.dart';

class PlanMakeAppBarBase {
  AppBar buildAppBar(BuildContext context,
      [Color? backgroundColor, double? elevation]) {
    return AppBar(
      elevation: elevation ?? 0,
      backgroundColor: backgroundColor ?? Colors.transparent,
      shadowColor: const Color(0xfff6f6f6),
      leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return BoardMainView();
            }));
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
