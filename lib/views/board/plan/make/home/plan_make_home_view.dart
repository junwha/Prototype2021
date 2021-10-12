import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/board/place_data_props.dart';
import 'package:prototype2021/handler/board/plan/plan_map_handler.dart';
import 'package:prototype2021/handler/board/plan/plan_make_calendar_handler.dart';
import 'package:prototype2021/views/board/plan/make/list_item/plan_list_item.dart';
import 'package:prototype2021/views/board/plan/make/home/mixin/ai_dialog.dart';
import 'package:prototype2021/views/board/plan/make/home/mixin/bottom_app_bar.dart';
import 'package:prototype2021/views/board/plan/make/home/mixin/constants.dart';
import 'package:prototype2021/views/board/plan/make/home/mixin/header.dart';
import 'package:prototype2021/views/board/plan/make/home/mixin/helper.dart';
import 'package:prototype2021/views/board/plan/make/home/mixin/main.dart';
import 'package:prototype2021/views/board/plan/make/mixin/plan_make_appbar_base.dart';
import 'package:prototype2021/views/board/plan/make/map/plan_map.dart';
import 'package:prototype2021/views/board/plan/make/mixin/plan_make_navigator.dart';
import 'package:prototype2021/views/board/plan/make/plan_make_view.dart';
import 'package:provider/provider.dart';

class PlanMakeHomeView extends StatefulWidget {
  final void Function(Navigate, [PlanMakeViewMode?]) navigator;

  const PlanMakeHomeView({required this.navigator});

  @override
  PlanMakeHomeViewState createState() =>
      PlanMakeHomeViewState(navigator: navigator);
}

class PlanMakeHomeViewState extends State<PlanMakeHomeView>
    with
        ChangeNotifier,
        PlanMakeAppBarBase,
        TickerProviderStateMixin,
        /*
         * These Mixins below have children widgets and helper Functions
         * PlanMakeHome widget uses
        */
        PlanMakeHomeAIDialogMixin,
        PlanMakeHomeBottomAppBarMixin,
        PlanMakeHomeHeaderMixin,
        PlanMakeHomeMainMixin,
        PlanMakeHomeHelper
    implements
        PlanMakeNavigator {
  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

  final void Function(Navigate, [PlanMakeViewMode?]) navigator;

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
  PlaceDataInterface? copiedData;

  void setCopiedData(String? dataId, PlaceDataInterface? data) {
    setState(() {
      copiedDataId = dataId;
      copiedData = data;
    });
  }

  void insertCopiedData(PlanMakeHandler calendarHandler, int dateIndex,
      PlaceDataInterface data, int indexToInsert) {
    calendarHandler.insertPlaceData(dateIndex, data, indexToInsert);
  }

  bool isMapEnabled = false;

  @override
  void onMapButtonTap() {
    setState(() {
      isMapEnabled = !isMapEnabled;
    });
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

  PlanMakeHomeViewState({required this.navigator}) {
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
    _scrollController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: buildAppBar(
        context,
        backgroundColor: _appBarColor,
        elevation: _appBarElevation,
        navigator: () => navigator(Navigate.backward),
      ),
      body: ScreenUtilInit(
          designSize: Size(3200, 1440),
          builder: () {
            return buildBody(context);
          }),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }

  NotificationListener buildBody(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollNotification) =>
            onScrollNotificationHandler(
              scrollNotification,
              _scrollController,
              _onTop,
              _setOnTop,
            ),
        child: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
              buildHeader(
                context,
                backNavigator: () => navigator(Navigate.backward),
              ),
              buildMain(context),
            ],
          ),
        )));
  }

  Widget buildMain(BuildContext context) {
    PlanMakeHandler calendarHandler = Provider.of<PlanMakeHandler>(context);

    List<Widget> planListItemWidgets =
        List.generate(calendarHandler.dateDifference!, (index) {
      return PlanListItem(
        dateIndex: index,
        incrementOpenedCount: _incrementOpenedCount,
        decrementOpenedCount: _decrementOpenedCount,
      );
    });

    return Container(
      child: Column(
        children: [
          Container(height: 50), // Top placeholder
          buildPlanMap(),
          buildPlanListItemsHeader(mode, _setMode,
              _planListItemsHeaderElevation, _sizeAnimation, _borderColor),
          buildTopShadowHidingContainer(_blindContainerColor),
          Column(children: planListItemWidgets),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.white),
      width: MediaQuery.of(context).size.width,
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height),
    );
  }

  Container buildPlanMap() {
    PlanMapHandler handler = Provider.of<PlanMapHandler>(context);
    return Container(
      height: isMapEnabled ? 200 : 0,
      child: handler.mapLoaded ? PlanMap() : SizedBox(),
    );
  }

  Container buildBottomAppBar(BuildContext context) {
    PlanMakeHandler calendarHandler = Provider.of<PlanMakeHandler>(context);
    bool onModeAdd = mode == PlanMakeMode.add;
    void _onEditDoneButtonTap() {
      _setMode(PlanMakeMode.add);
      setCopiedData(null, null);
    }

    void _onResetButtonTap() {
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
                    : buildResetButton(_onResetButtonTap)),
            Expanded(
                flex: onModeAdd ? 4 : 6,
                child: onModeAdd
                    ? buildSaveButton(() => navigator(Navigate.forward))
                    : buildEditDoneButton(_onEditDoneButtonTap)),
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
