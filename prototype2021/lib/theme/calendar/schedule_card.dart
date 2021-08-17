import 'package:flutter/material.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/theme/calendar/plan_make_home.dart';
import 'package:prototype2021/theme/circular_wrapper.dart';

class ScheduleCard extends StatelessWidget with ScheduleCardHelpers {
  final PlaceDataProps data;
  final int order;
  final PlanMakeMode mode;

  ScheduleCard({required this.data, required this.order, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          child: Row(
            children: [
              Container(
                child: Row(
                  children: [
                    buildLeading(),
                    SizedBox(
                      width: 10,
                    ),
                    buildInfo()
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
              buildActions(),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(3, 3),
                    blurRadius: 3,
                    spreadRadius: 0)
              ],
              color: const Color(0xffffffff))),
      padding: EdgeInsets.only(right: 4),
    );
  }

  CircularWrapper buildLeading() {
    return CircularWrapper(
      size: 26,
      icon: data.types == 'memo'
          ? Image.asset('assets/icons/ic_calender_memo_white.png')
          : Text(order.toString(),
              style: const TextStyle(
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0),
              textAlign: TextAlign.left),
      backgroundColor: placeColorByType(data.types),
    );
  }

  Container buildInfo() {
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

  Container buildActions() {
    if (mode == PlanMakeMode.edit) {
      return Container(child: buildEditActions());
    }

    if (mode == PlanMakeMode.delete) {
      return Container(
        child: IconButton(
          onPressed: () {},
          icon: Image.asset('assets/icons/ic_delete.png'),
        ),
      );
    }

    return Container(
      child: data.types == "memo" ? SizedBox() : placeIconByType(data.types),
    );
  }

  Row buildEditActions() {
    return Row(
      children: [
        TextButton(
            onPressed: () {},
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
    );
  }
}

mixin ScheduleCardHelpers {
  Color placeColorByType(String type) {
    switch (type) {
      case "attraction":
        return const Color(0xff4080ff);
      case "cafe":
        return const Color(0xffff6e00);
      case "restaurant":
        return const Color(0xffff6e00);
      case "accomodations":
        return const Color(0xff6be6a7);
      default:
        return const Color(0xffaaaaaa);
    }
  }

  Image placeIconByType(String type) {
    switch (type) {
      case "attraction":
        return Image.asset('assets/icons/ic_calender_destination.png');
      case "cafe":
        return Image.asset('assets/icons/ic_calender_food.png');
      case "restaurant":
        return Image.asset('assets/icons/ic_calender_food.png');
      case "accomodations":
        return Image.asset('assets/icons/ic_calender_room.png');
      case "memo":
        return Image.asset('assets/icons/ic_calender_memo_white.png');
      default:
        return Image.asset('assets/icons/ic_calender_destination.png');
    }
  }
}
