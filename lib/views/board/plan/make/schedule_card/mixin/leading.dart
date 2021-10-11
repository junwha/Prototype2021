import 'package:flutter/material.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/model/board/place_data_props.dart';
import 'package:prototype2021/utils/string_tools/trucater.dart';
import 'package:prototype2021/widgets/shapes/circular_wrapper.dart';

mixin ScheduleCardLeadingMixin on StatelessWidget {
  CircularWrapper buildLeading(
      ContentType type, int order, Color backgroundColor) {
    return CircularWrapper(
        size: 26,
        icon: type == ContentType.memo
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

  Container buildInfo(PlaceDataInterface data) {
    List<Widget> infoWidgets = [];
    if (data.contentType == ContentType.memo) {
      infoWidgets.add(Text(data.memo,
          style: const TextStyle(
              color: const Color(0xff707070),
              fontWeight: FontWeight.w700,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 15.0),
          textAlign: TextAlign.left));
    } else {
      infoWidgets.add(Text(truncate(data.name, 19),
          style: const TextStyle(
              color: const Color(0xff707070),
              fontWeight: FontWeight.w700,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 15.0),
          textAlign: TextAlign.left));
      if (data.address != null) {
        infoWidgets.addAll([
          SizedBox(
            height: 2,
          ),
          Text(truncate(data.address!, 19),
              style: const TextStyle(
                  color: const Color(0xff707070),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 9.0),
              textAlign: TextAlign.left),
        ]);
      }
    }

    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: infoWidgets,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
