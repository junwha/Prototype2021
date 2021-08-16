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
    with PlanMakeViewBase, TickerProviderStateMixin, ChangeNotifier {
  bool _onTop = true;
  void Function(bool)? _setOnTop(bool isOnTop) {
    setState(() {
      _onTop = isOnTop;
    });
  }

  ValueNotifier _openedCountNotifier = ValueNotifier<int>(0);
  void _incrementOpenedCount() {
    _openedCountNotifier.value = _openedCountNotifier.value + 1;
    _openedCountNotifier.notifyListeners();
  }

  void _decrementOpenedCount() {
    _openedCountNotifier.value = _openedCountNotifier.value - 1;
    _openedCountNotifier.notifyListeners();
  }

  bool _expanded = false;
  void _setExpanded(bool expanded) {
    setState(() {
      _expanded = expanded;
    });
  }

  late AnimationController _scrollController;
  late AnimationController _sizeController;
  late Animation _appBarColorAnimation;
  late Animation _shadowColorAnimation;
  late Animation _borderColorAnimation;
  late Animation<double> _sizeAnimation;
  Color _appBarColor = Colors.transparent;
  Color _shadowColor = Colors.white;
  Color _borderColor = const Color(0xff707070).withOpacity(0.52);
  double _appBarElevation = 0;

  _PlanMakeHomeState() {
    _scrollController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _sizeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _appBarColorAnimation =
        ColorTween(begin: const Color(0xfff6f6f6), end: Colors.white)
            .animate(_scrollController);
    _shadowColorAnimation = ColorTween(
            begin: Colors.white.withOpacity(0.1),
            end: const Color(0x29000000).withOpacity(0.1))
        .animate(_scrollController);
    _borderColorAnimation = ColorTween(
            begin: const Color(0xff707070).withOpacity(0.52), end: Colors.white)
        .animate(_scrollController);
    _sizeAnimation = Tween<double>(begin: 0, end: 1).animate(_sizeController);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _appBarColor = _appBarColorAnimation.value;
        _shadowColor = _shadowColorAnimation.value;
        _borderColor = _borderColorAnimation.value;
      });
    });
    _openedCountNotifier.addListener(() {
      if (_openedCountNotifier.value == 0) {
        if (_expanded) {
          _setExpanded(false);
          _sizeController.reverse();
        }
      } else {
        if (!_expanded) {
          _setExpanded(true);
          _sizeController.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: buildAppBar(context, _appBarColor, _appBarElevation),
      body: ValueListenableBuilder(
        valueListenable: _openedCountNotifier,
        builder: (BuildContext context, _, __) {
          return buildBody(context);
        },
      ),
    );
  }

  NotificationListener buildBody(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollNotification) {
          if (scrollNotification.metrics.pixels < 1) {
            // When screen is on top
            if (!_onTop) {
              _setOnTop(true);
              _scrollController.reverse();
              setState(() {
                _appBarElevation = 0;
              });
            }
          } else {
            // When screen is not on top
            if (_onTop) {
              _setOnTop(false);
              _scrollController.forward().whenCompleteOrCancel(() {
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
    List<Widget> planListItemWidgets =
        List.generate(calendarHandler.dateDifference!, (index) {
      return PlanListItem(
        dateIndex: index,
        incrementOpenedCount: _incrementOpenedCount,
        decrementOpenedCount: _decrementOpenedCount,
      );
    });
    planListItemWidgets.insertAll(0, [
      SizedBox(
        height: 50,
      ),
      buildPlanListItemsHeader(),
    ]);
    return Container(
      child: Column(children: planListItemWidgets),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.white),
      width: MediaQuery.of(context).size.width,
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height),
    );
  }

  Container buildPlanListItemsHeader() {
    return Container(
      child: SizeTransition(
        sizeFactor: _sizeAnimation,
        axisAlignment: 1.0,
        child: Container(
          child: Container(
            child: Row(
              children: [
                Text("일정",
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                    textAlign: TextAlign.left),
                GestureDetector(
                  onTap: () {},
                  child: Opacity(
                    opacity: 0.2,
                    child: Container(
                        child: Center(
                          child: Text("편집",
                              style: const TextStyle(
                                  color: const Color(0x99707070),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 11.0),
                              textAlign: TextAlign.left),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(
                                color: const Color(0xff707070), width: 1),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x29000000),
                                  offset: Offset(2, 2),
                                  blurRadius: 2,
                                  spreadRadius: 0)
                            ],
                            color: const Color(0xffffffff)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                        alignment: Alignment.topCenter),
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            padding: EdgeInsets.only(right: 10, left: 13, bottom: 14, top: 14),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: _borderColor, width: 0.5))),
          ),
          padding: EdgeInsets.symmetric(horizontal: PlanListItemPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: _shadowColor,
                  offset: Offset(0, 10),
                  blurRadius: 6.0,
                  spreadRadius: 0)
            ],
          ),
        ),
      ),
    );
  }
}
