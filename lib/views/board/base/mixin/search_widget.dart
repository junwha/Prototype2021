import 'package:flutter/material.dart';

mixin BoardSearchWidgetMixin {
  Container buildSearchBodyHeader() {
    return Container(
      child: Text("최근 검색어",
          style: const TextStyle(
              color: const Color(0xff555555),
              fontWeight: FontWeight.w700,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 17.0),
          textAlign: TextAlign.left),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(bottom: 20),
    );
  }

  TextButton buildResetSearchesButton({required void Function() onPressed}) {
    return TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(Icons.delete_forever, color: const Color(0xff555555)),
            SizedBox(width: 7),
            Text(
              "전체 삭제",
              style: const TextStyle(
                  color: const Color(0xff555555),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 15.0),
              textAlign: TextAlign.center,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ));
  }

  Widget buildRecentSearchItem(
      {required String text,
      void Function()? onActionPressed,
      void Function()? onTap}) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        child: Row(
          children: [
            Text(text,
                style: const TextStyle(
                    color: const Color(0xff555555),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0),
                textAlign: TextAlign.left),
            IconButton(
                onPressed: onActionPressed,
                icon: Icon(Icons.cancel,
                    color: const Color(0xffdadada), size: 24)),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
