import 'package:flutter/material.dart';
import 'package:prototype2021/data/place_data_props.dart';
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

class PlanMakeHomeView extends StatefulWidget {
  @override
  PlanMakeHomeViewState createState() => PlanMakeHomeViewState();
}

class PlanMakeHomeViewState extends State<PlanMakeHomeView>
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

  int openedCount = 0;
  void _incrementOpenedCount() {
    setState(() {
      openedCount = openedCount + 1;
    });
    if (!_expanded) {
      _setExpanded(true);
      _sizeController.forward().whenCompleteOrCancel(() {
        setState(() {
          _blindContainerColor = Colors.white;
        });
      });
    }
  }

  void _decrementOpenedCount() {
    setState(() {
      openedCount = openedCount - 1;
    });
    if (openedCount == 0 && _expanded) {
      _setExpanded(false);
      _sizeController.reverse();
      setState(() {
        _blindContainerColor = Colors.transparent;
      });
    }
  }

  bool _expanded = false;
  void _setExpanded(bool expanded) {
    setState(() {
      _expanded = expanded;
    });
  }

  PlanMakeMode mode = PlanMakeMode.add;
  void _setMode(PlanMakeMode planMakeMode) {
    setState(() {
      mode = planMakeMode;
    });
  }

  bool onDrag = false;
  void setOnDrag(bool isOnDrag) {
    setState(() {
      onDrag = isOnDrag;
    });
  }

  String? copiedDataId;
  PlaceDataProps? copiedData;
  void setCopiedData(String? dataId, PlaceDataProps? data) {
    setState(() {
      copiedDataId = dataId;
      copiedData = data;
    });
  }

  void insertCopiedData(PlanMakeCalendarModel calendarHandler, int dateIndex,
      PlaceDataProps data, int indexToInsert) {
    calendarHandler.insertPlaceData(dateIndex, data, indexToInsert);
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

  PlanMakeHomeViewState() {
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
      body: buildBody(context),
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
      );
    });
    planListItemWidgets.insertAll(0, [
      Container(
        height: 50,
      ),
      /* IMPORTANT!! REPLACE THIS PSEUDO MAP TO REAL MAP! */
      PseudoMap(),
      buildPlanListItemsHeader(mode, _setMode, _planListItemsHeaderElevation,
          _sizeAnimation, _borderColor),
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
    PlanMakeCalendarModel calendarHandler =
        Provider.of<PlanMakeCalendarModel>(context);
    bool onModeAdd = mode == PlanMakeMode.add;
    void onEditDoneButtonTap() {
      _setMode(PlanMakeMode.add);
      setCopiedData(null, null);
    }

    void onResetButtonTap() {
      calendarHandler.resetPlanListItems();
      _setMode(PlanMakeMode.add);
      _sizeController.reverse();
      setCopiedData(null, null);
      setState(() {
        openedCount = 0;
        _expanded = false;
        _blindContainerColor = Colors.transparent;
      });
    }

    return Container(
      child: Container(
        child: Row(
          children: [
            Expanded(
                flex: onModeAdd ? 6 : 4,
                child: onModeAdd
                    ? buildAIButton(context, buildAIDialog(context))
                    : buildResetButton(onResetButtonTap)),
            Expanded(
                flex: onModeAdd ? 4 : 6,
                child: onModeAdd
                    ? buildSaveButton()
                    : buildEditDoneButton(onEditDoneButtonTap)),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        constraints: BoxConstraints(maxHeight: 150),
      ),
      decoration: BoxDecoration(color: Colors.white),
    );
  }
}

class PseudoMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
