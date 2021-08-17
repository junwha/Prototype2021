import 'package:flutter/material.dart';
import 'package:prototype2021/model/plan_make_calendar_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/calendar/plan_list_item.dart';
import 'package:prototype2021/theme/calendar/plan_make_calendar.dart';
import 'package:prototype2021/theme/calendar/plan_make_view_base.dart';
import 'package:prototype2021/theme/circular_wrapper.dart';
import 'package:prototype2021/theme/pop_up.dart';
import 'package:provider/provider.dart';

enum PlanMakeMode { add, edit, delete }

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

  ValueNotifier _modeNotifier = ValueNotifier<PlanMakeMode>(PlanMakeMode.add);
  void _setMode(PlanMakeMode mode) {
    _modeNotifier.value = mode;
    _modeNotifier.notifyListeners();
  }

  late AnimationController _scrollController;
  late AnimationController _sizeController;
  late Animation _appBarColorAnimation;
  late Animation _borderColorAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<double> _appBarShadowAnimation;
  late Animation<double> _planListItemsHeaderShadowAnimation;
  Color _appBarColor = Colors.transparent;
  Color _borderColor = const Color(0xff707070).withOpacity(0.52);
  double _appBarElevation = 0;
  double _planListItemsHeaderElevation = 0;
  Color _blindContainerColor = Colors.transparent;

  _PlanMakeHomeState() {
    _scrollController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _sizeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _appBarColorAnimation =
        ColorTween(begin: const Color(0xfff6f6f6), end: Colors.white)
            .animate(_scrollController);
    _borderColorAnimation = ColorTween(
            begin: const Color(0xff707070).withOpacity(0.52), end: Colors.white)
        .animate(_scrollController);
    _sizeAnimation = Tween<double>(begin: 0, end: 1).animate(_sizeController);
    _appBarShadowAnimation =
        Tween<double>(begin: 0, end: 3).animate(_scrollController);
    _planListItemsHeaderShadowAnimation =
        Tween<double>(begin: 0, end: 8).animate(_scrollController);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _appBarColor = _appBarColorAnimation.value;
        _borderColor = _borderColorAnimation.value;
        _appBarElevation = _appBarShadowAnimation.value;
        _planListItemsHeaderElevation =
            _planListItemsHeaderShadowAnimation.value;
      });
    });
    _openedCountNotifier.addListener(() {
      if (_openedCountNotifier.value == 0) {
        if (_expanded) {
          _setExpanded(false);
          _sizeController.reverse();
          setState(() {
            _blindContainerColor = Colors.transparent;
          });
        }
      } else {
        if (!_expanded) {
          _setExpanded(true);
          _sizeController.forward().whenCompleteOrCancel(() {
            setState(() {
              _blindContainerColor = Colors.white;
            });
          });
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
        valueListenable: _modeNotifier,
        builder: (context, _, __) => ValueListenableBuilder(
            valueListenable: _openedCountNotifier,
            builder: (context, _, __) => buildBody(context)),
      ),
      bottomNavigationBar: buildBottomAppBar(),
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
            }
          } else {
            // When screen is not on top
            if (_onTop) {
              _setOnTop(false);
              _scrollController.forward();
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
          mode: _modeNotifier.value);
    });
    planListItemWidgets.insertAll(0, [
      Container(
        height: 50,
      ),
      buildPlanListItemsHeader(),
      buildBlindContainer(),
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

  Container buildBlindContainer() {
    return Container(
      child: Stack(children: [
        Positioned.fill(
          child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 10,
                decoration: BoxDecoration(color: _blindContainerColor),
              )),
          top: -60, // Blind Container height + planListItemsHeaderHeight
        )
      ], clipBehavior: Clip.none),
      height: 10,
    );
  }

  Container buildPlanListItemsHeader() {
    return Container(
      child: PhysicalModel(
        color: const Color(0x29000000).withOpacity(0.1),
        elevation: _planListItemsHeaderElevation,
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
                    onTap: () {
                      switch (_modeNotifier.value) {
                        case PlanMakeMode.add:
                          _setMode(PlanMakeMode.edit);
                          break;
                        case PlanMakeMode.edit:
                          _setMode(PlanMakeMode.delete);
                          break;
                        case PlanMakeMode.delete:
                          _setMode(PlanMakeMode.edit);
                          break;
                        default:
                          _setMode(PlanMakeMode.add);
                          break;
                      }
                    },
                    child: Opacity(
                      opacity: 0.4,
                      child: Container(
                          child: Center(
                            child: Text(
                                _modeNotifier.value == PlanMakeMode.edit
                                    ? "삭제"
                                    : "편집",
                                style: const TextStyle(
                                    color: const Color(0x99707070),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Roboto",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 11.0),
                                textAlign: TextAlign.left),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
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
              padding:
                  EdgeInsets.only(right: 10, left: 13, bottom: 14, top: 14),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: _borderColor, width: 0.5))),
            ),
            padding: EdgeInsets.symmetric(horizontal: PlanListItemPadding),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 50,
          ),
        ),
      ),
    );
  }

  Container buildBottomAppBar() {
    return Container(
      child: SafeArea(
          child: Container(
        child: Row(
          children: [
            Expanded(
                flex: _modeNotifier.value == PlanMakeMode.add ? 6 : 4,
                child: buildBottomRoundedButton([
                  Image.asset(
                    'assets/icons/img_ai_big.png',
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 26,
                  ),
                  Text("AI 추천",
                      style: const TextStyle(
                          color: const Color(0xff555555),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 17.0),
                      textAlign: TextAlign.center)
                ], () {
                  showDialog(
                      context: context,
                      builder: (context) => buildAIDialog(context));
                })),
            Expanded(
                flex: _modeNotifier.value == PlanMakeMode.add ? 4 : 6,
                child: buildBottomRoundedButton([
                  Text("저장하기",
                      style: const TextStyle(
                          color: const Color(0xff555555),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 17.0),
                      textAlign: TextAlign.center)
                ])),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        padding: EdgeInsets.only(bottom: 30),
      )),
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  Container buildBottomRoundedButton(List<Widget> children,
      [void Function()? onTap]) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Row(
            children: children,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(11)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(3, 3),
                    blurRadius: 3,
                    spreadRadius: 0)
              ],
              color: const Color(0xfff6f6f6)),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: 50,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
    );
  }

  TBLargeDialog buildAIDialog(BuildContext context) {
    return TBLargeDialog(
        title: "AI 추천",
        body: Center(
          child: Column(
            children: [
              buildAIDialogButton("자동 플랜 설계", true, () {}),
              buildAIDialogButton("일정 순서 조정", true, () {}),
              buildAIDialogButton("다음 여행지 추천", false, () {}),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ));
  }

  InkWell buildAIDialogButton(
      String dialog, bool isPaid, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Container(
          child: Stack(
            children: [
              Positioned.fill(
                  child: Align(
                      child: Text(dialog,
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0),
                          textAlign: TextAlign.center),
                      alignment: Alignment.center)),
              Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: isPaid
                        ? Image.asset('assets/icons/ic_calender_star_paid.png')
                        : SizedBox(),
                  ),
                  top: -20,
                  right:
                      -120) // This should be fixed in near future, to have a position relative to the text above
            ],
          ),
          height: 80,
          alignment: Alignment.center,
          clipBehavior: Clip.none,
        ),
        alignment: Alignment.center,
        // padding: EdgeInsets.symmetric(vertical: 27),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0, color: const Color(0xffe6e6e6))),
            color: Colors.white),
        clipBehavior: Clip.none,
      ),
    );
  }
}
