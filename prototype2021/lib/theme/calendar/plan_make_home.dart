import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/calendar/plan_make_view_base.dart';
import 'package:prototype2021/theme/circular_wrapper.dart';

class PlanMakeHome extends StatefulWidget {
  @override
  _PlanMakeHomeState createState() => _PlanMakeHomeState();
}

class _PlanMakeHomeState extends State<PlanMakeHome>
    with PlanMakeViewBase, SingleTickerProviderStateMixin {
  bool _onTop = true;
  void Function(bool)? setOnTop(bool isOnTop) {
    setState(() {
      _onTop = isOnTop;
    });
  }

  late AnimationController controller;
  late ColorTween topToBottomColor;
  late ColorTween bottomToTopColor;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    topToBottomColor =
        ColorTween(begin: const Color(0xfff6f6f6), end: Colors.white);
    bottomToTopColor =
        ColorTween(begin: Colors.white, end: const Color(0xfff6f6f6));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  NotificationListener buildBody(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollNotification) {
          if (scrollNotification.metrics.pixels == 0) {
            if (!_onTop) {
              setOnTop(true);
              bottomToTopColor.animate(controller);
            }
          } else {
            if (_onTop) {
              setOnTop(false);
              topToBottomColor.animate(controller);
            }
          }
          return false;
        },
        child: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [buildHeader(context), buildMain(context)],
          ),
        )));
  }

  Container buildHeader(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Row(
              children: [
                Text("여행 일정",
                    style: const TextStyle(
                        color: const Color(0xff4080ff),
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 22.0),
                    textAlign: TextAlign.left),
                SizedBox(width: 5),
                Text("짜기",
                    style: const TextStyle(
                        color: const Color(0xff9dbeff),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0),
                    textAlign: TextAlign.left)
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ),
          Container(
            child: Row(
              children: [
                CircularWrapper(
                  icon: Image.asset('assets/icons/map.png'),
                  onTap: () {},
                  size: 34,
                  shadow: true,
                ),
                SizedBox(
                  width: 10 * pt,
                ),
                CircularWrapper(
                  icon: Image.asset('assets/icons/ic_calender_calender.png'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  size: 34,
                  shadow: true,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      padding: EdgeInsets.only(top: 50 * pt, left: 40, right: 40, bottom: 10),
    );
  }

  Container buildMain(BuildContext context) {
    return Container(
      child: Column(),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.white),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
  }
}
