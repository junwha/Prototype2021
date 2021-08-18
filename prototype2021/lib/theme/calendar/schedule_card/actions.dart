import 'package:flutter/material.dart';

mixin ScheduleCardActionsMixin on StatelessWidget {
  Container buildDefaultActions(
      BuildContext context, String types, Widget icon) {
    return Container(
      child: types == "memo" ? SizedBox() : icon,
    );
  }

  Container buildDeleteActions(BuildContext context,
      [void Function()? onPressed]) {
    return Container(
      child: IconButton(
        onPressed: onPressed,
        icon: Image.asset('assets/icons/ic_delete.png'),
      ),
    );
  }

  Container buildEditActions(BuildContext context,
      [void Function()? onPressed]) {
    return Container(
      child: Row(
        children: [
          TextButton(
              onPressed: onPressed,
              child: Text("복사",
                  style: const TextStyle(
                      color: const Color(0xff707070),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 9.0),
                  textAlign: TextAlign.left)),
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/ic_hamburger_menu.png'))
        ],
      ),
    );
  }
}
