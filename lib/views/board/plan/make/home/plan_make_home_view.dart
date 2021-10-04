import 'package:flutter/material.dart';
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
import 'package:provider/provider.dart';

class PlanMakeHomeView extends StatefulWidget {
  @override
  PlanMakeHomeViewState createState() => PlanMakeHomeViewState();
}

class PlanMakeHomeViewState extends State<PlanMakeHomeView>
    with
        PlanMakeAppBarBase,
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

  void insertCopiedData(PlanMakeCalendarHandler calendarHandler, int dateIndex,
      PlaceDataProps data, int indexToInsert) {
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
    _sizeController.dispose();
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

  Widget buildMain(BuildContext context) {
    PlanMakeCalendarHandler calendarHandler =
        Provider.of<PlanMakeCalendarHandler>(context);

    List<Widget> planListItemWidgets =
        List.generate(calendarHandler.dateDifference!, (index) {
      return PlanListItem(
        dateIndex: index,
        incrementOpenedCount: _incrementOpenedCount,
        decrementOpenedCount: _decrementOpenedCount,
      );
    });
    return ChangeNotifierProvider<PlanMapHandler>(
      create: (_) {
        PlanMapHandler model = PlanMapHandler(LatLng(35.5763,
            129.1893)); // TODO: replace this position as current position;
        calendarHandler.addListener(() {
          // Notify to plan map model when the calendar handler has changed.
          try {
            if (calendarHandler.planListItems != null)
              model.updatePlaceData(calendarHandler.planListItems!);
            else {
              // if the items are null, generate empty List with dateDifference. this logic is for generating date buttons.
              model.updatePlaceData(List.generate(
                  calendarHandler.dateDifference!, (index) => []));
            }
          } catch (e) {
            print(e);
          }
        });
        return model;
      },
      child: Container(
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            Container(
                height: isMapEnabled ? 200 : 0,
                child: Consumer(builder:
                    (BuildContext context, PlanMapHandler model, Widget? _) {
                  return model.mapLoaded ? PlanMap() : SizedBox();
                })),
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
      ),
    );
  }

  Container buildBottomAppBar(BuildContext context) {
    PlanMakeCalendarHandler calendarHandler =
        Provider.of<PlanMakeCalendarHandler>(context);
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
    return Text("asddf");
  }
}
