import 'package:flutter/material.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/widgets/shapes/circular_wrapper.dart';

mixin ScheduleCardLeadingMixin on StatelessWidget {
  CircularWrapper buildLeading(String types, int order, Color backgroundColor) {
    return CircularWrapper(
        size: 26,
        icon: types == 'memo'
            ? Image.asset('assets/icons/ic_calender_memo_white.png')
            : Text(order.toString(),
                style: const TextStyle(
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0),
                textAlign: TextAlign.left),
        backgroundColor: backgroundColor);
  }

  Container buildInfo(PlaceDataProps data) {
    List<Widget> infoWidgets = data.types == "memo"
        ? [
            Text(data.memo,
                style: const TextStyle(
                    color: const Color(0xff707070),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0),
                textAlign: TextAlign.left)
          ]
        : [
            Text(data.name,
                style: const TextStyle(
                    color: const Color(0xff707070),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0),
                textAlign: TextAlign.left),
            SizedBox(
              height: 2,
            ),
            Text(data.address ?? "",
                style: const TextStyle(
                    color: const Color(0xff707070),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 9.0),
                textAlign: TextAlign.left)
          ];

    return Container(
      child: Column(
        children: infoWidgets,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
