import 'package:flutter/material.dart';

mixin BoardMainViewSearchWidgetMixin {
  Center buildCenterNotice(String text) {
    return Center(
      child: Text(text,
          style: const TextStyle(
              color: const Color(0xff555555),
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 14.0),
          textAlign: TextAlign.center),
    );
  }

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
