import 'package:flutter/material.dart';
import 'package:prototype2021/model/plan_make_calendar_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/calendar/plan_list_item.dart';
import 'package:prototype2021/theme/calendar/plan_make_calendar.dart';
import 'package:prototype2021/theme/calendar/plan_make_view_base.dart';
import 'package:prototype2021/theme/circular_wrapper.dart';
import 'package:provider/provider.dart';

class PlanMakeHome extends StatefulWidget {
  @override
  _PlanMakeHomeState createState() => _PlanMakeHomeState();
}

class _PlanMakeHomeState extends State<PlanMakeHome>
    with PlanMakeViewBase, TickerProviderStateMixin {
  bool _onTop = true;
  void Function(bool)? _setOnTop(bool isOnTop) {
    setState(() {
      _onTop = isOnTop;
    });
  }

  late AnimationController _controller;
  late Animation _colorAnimation;
  Color _appBarColor = Colors.transparent;
  double _appBarElevation = 0;

  _PlanMakeHomeState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _colorAnimation =
        ColorTween(begin: const Color(0xfff6f6f6), end: Colors.white)
            .animate(_controller);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _appBarColor = _colorAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: buildAppBar(context, _appBarColor, _appBarElevation),
      body: buildBody(context),
    );
  }

  NotificationListener buildBody(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollNotification) {
          if (scrollNotification.metrics.pixels < 1) {
            // When screen is on top
            if (!_onTop) {
              _setOnTop(true);
              _controller.reverse();
              setState(() {
                _appBarElevation = 0;
              });
            }
          } else {
            // When screen is not on top
            if (_onTop) {
              _setOnTop(false);
              _controller.forward().whenCompleteOrCancel(() {
                setState(() {
                  _appBarElevation = 3;
                });
              });
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
    PlanMakeCalendarModel calendarHandler =
        Provider.of<PlanMakeCalendarModel>(context);
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ChangeNotifierProvider(
                        create: (_) => calendarHandler.inherit(),
                        child: PlanMakeCalendar(),
                      );
                    }));
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
    PlanMakeCalendarModel calendarHandler =
        Provider.of<PlanMakeCalendarModel>(context);
    List<Widget> widgets =
        List.generate(calendarHandler.dateDifference!, (index) {
      return PlanListItem(dateIndex: index);
    });
    widgets.insert(
        0,
        SizedBox(
          height: 40,
        ));
    return Container(
      child: Column(children: widgets),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.white),
      width: MediaQuery.of(context).size.width,
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height),
    );
  }
}
