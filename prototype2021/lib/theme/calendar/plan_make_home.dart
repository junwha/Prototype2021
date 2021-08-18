import 'package:flutter/material.dart';
import 'package:prototype2021/model/plan_make_calendar_model.dart';
import 'package:prototype2021/theme/calendar/plan_list_item.dart';
import 'package:prototype2021/theme/calendar/plan_make_home/ai_dialog.dart';
import 'package:prototype2021/theme/calendar/plan_make_home/bottom_app_bar.dart';
import 'package:prototype2021/theme/calendar/plan_make_home/constants.dart';
import 'package:prototype2021/theme/calendar/plan_make_home/header.dart';
import 'package:prototype2021/theme/calendar/plan_make_home/helper.dart';
import 'package:prototype2021/theme/calendar/plan_make_home/main.dart';
import 'package:prototype2021/theme/calendar/plan_make_view_base.dart';
import 'package:provider/provider.dart';

class PlanMakeHome extends StatefulWidget {
  @override
  _PlanMakeHomeState createState() => _PlanMakeHomeState();
}

class _PlanMakeHomeState extends State<PlanMakeHome>
    with
        PlanMakeViewBase,
        TickerProviderStateMixin,
        ChangeNotifier,
        /* 
         * These Mixins below have children widgets and helper Functions 
         * PlanMakeHome widget uses 
        */
        PlanMakeHomeAIDialogMixin,
        PlanMakeHomeBottomAppBarMixin,
        PlanMakeHomeHeaderMixin,
        PlanMakeHomeMainMixin,
        PlanMakeHomeHelper {
  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

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

  /* =================================/================================= */
  /* =================CONSTRUCTORS & LIFE CYCLE METHODS================= */
  /* =================================/================================= */

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

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

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
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }

  NotificationListener buildBody(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollNotification) =>
            onScrollNotificationHandler(
                scrollNotification, _scrollController, _onTop, _setOnTop),
        child: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [buildHeader(context), buildMain(context)],
          ),
        )));
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
      buildPlanListItemsHeader(_modeNotifier, _setMode,
          _planListItemsHeaderElevation, _sizeAnimation, _borderColor),
      buildTopShadowHidingContainer(_blindContainerColor),
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

  Container buildBottomAppBar(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Container(
        child: Row(
          children: [
            Expanded(
                flex: _modeNotifier.value == PlanMakeMode.add ? 6 : 4,
                child: buildAIButton(context, buildAIDialog(context))),
            Expanded(
                flex: _modeNotifier.value == PlanMakeMode.add ? 4 : 6,
                child: buildSaveButton()),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        padding: EdgeInsets.only(bottom: 30),
      )),
      decoration: BoxDecoration(color: Colors.white),
    );
  }
}
