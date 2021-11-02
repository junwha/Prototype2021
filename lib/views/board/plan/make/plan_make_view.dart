import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/handler/board/plan/plan_make_calendar_handler.dart';
import 'package:prototype2021/handler/board/plan/plan_map_handler.dart';
import 'package:prototype2021/utils/logger/logger.dart';
import 'package:prototype2021/views/board/plan/make/calendar/plan_make_calendar_view.dart';
import 'package:prototype2021/views/board/plan/make/home/plan_make_home_view.dart';
import 'package:prototype2021/views/board/plan/make/save/planMake.saved.0_view.dart';
import 'package:prototype2021/views/board/plan/make/save/planmake_save_view.dart';
import 'package:prototype2021/views/board/plan/make/select/plan_make_select_view.dart';
import 'package:provider/provider.dart';

enum Navigate {
  backward,
  forward,
  custom,
}

enum PlanMakeViewMode {
  /// 기간을 정하는 달력 화면입나다
  calendar,

  /// [PlanMakeViewMode.calendar] 다음에 나오는 화면
  /// 기간을 정하고 나면 여행 일정 짜기 화면입니다
  home,

  /// [PlanMakeViewMode.home] 에 있는 일정 리스트에서 + 버튼을 누르면 나오는 화면.
  /// 검색, 저장 목록, 요즘 뜨는 플랜, 컨텐츠를 볼 수 있다
  ///
  /// 현재는 컨텐츠만 열람 가능하다
  select,

  /// [PlanMakeViewMode.select] 에서 저장한 플랜, 저장한 컨텐츠를 누르면 나오는 화면이다
  /// [BoardMainView] 위젯을 사용한다
  ///
  /// 현재는 사용되지 않는다
  wishlist,

  /// [PlanMakeViewMode.select] 에서 검색 바를 누르면 나오는 화면이다
  /// [BoardMainView] 위젯을 사용한다
  ///
  /// 현재는 사용되지 않는다
  search,

  /// 플랜을 저장할 때 나오는 페이지
  save,

  /// 결과창
  result,
}

class PlanMakeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlanMakeHandler>(
            create: (_) => PlanMakeHandler(now: now)),
        ChangeNotifierProvider<PlanMapHandler>(
            create: (_) => PlanMapHandler(
                LatLng(37.5642135, 127.0016985))), // default (Seoul)
      ],
      child: _PlanMakeViewContent(),
    );
  }
}

class _PlanMakeViewContent extends StatefulWidget {
  const _PlanMakeViewContent();

  _PlanMakeViewContentState createState() => _PlanMakeViewContentState();
}

class _PlanMakeViewContentState extends State<_PlanMakeViewContent>
    with ChangeNotifier {
  PlanMakeViewMode viewMode = PlanMakeViewMode.calendar;
  void setViewMode(PlanMakeViewMode _viewMode) => setState(() {
        viewMode = _viewMode;
      });

  void Function(Navigate, [PlanMakeViewMode?]) navigatorFactory({
    PlanMakeViewMode? backward,
    PlanMakeViewMode? forward,
  }) {
    return (Navigate navigateDirection, [PlanMakeViewMode? customMode]) {
      if (navigateDirection == Navigate.custom && customMode != null) {
        setViewMode(customMode);
        return;
      }
      if (navigateDirection == Navigate.backward) {
        if (backward == null) {
          Navigator.pop(context);
          return;
        }
        setViewMode(backward);
      } else {
        if (forward == null) {
          return;
        }
        setViewMode(forward);
      }
    };
  }

  @override
  void initState() {
    super.initState();
    PlanMakeHandler handler =
        Provider.of<PlanMakeHandler>(context, listen: false);
    PlanMapHandler mapHandler =
        Provider.of<PlanMapHandler>(context, listen: false);
    Future<void> calendarHandlerListener() async {
      // Notify to plan map model when the calendar handler has changed.
      try {
        if (handler.planListItems != null) {
          Logger.group1("PlanListItems");
          await mapHandler.updatePlaceData(handler.planListItems!);
        } else {
          Logger.group1("No PlanListItems");
          // if the items are null, generate empty List with dateDifference. this logic is for generating date buttons.
          await mapHandler.updatePlaceData(
              List.generate(handler.dateDifference!, (index) => []));
        }
      } catch (e) {
        Logger.errorWithInfo(e, "plan_make_view.dart -> initState");
      }
    }

    handler.addListener(calendarHandlerListener);

    Logger.group1("Init map");

    Future.delayed(Duration.zero, () async {
      Position position = await Geolocator.getCurrentPosition();
      await mapHandler
          .updateCenterByLatLng(LatLng(position.latitude, position.longitude));
    });
  }

  // @override
  // void dispose() {
  //   PlanMakeHandler planMakeHandler = Provider.of<PlanMakeHandler>(context);
  //   PlanMapHandler planMapHandler = Provider.of<PlanMapHandler>(context);
  //   planMapHandler.doDispose();
  //   planMakeHandler.doDispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: buildPage(),
        onWillPop: () async {
          switch (viewMode) {
            case PlanMakeViewMode.home:
              setViewMode(PlanMakeViewMode.calendar);
              break;
            case PlanMakeViewMode.select:
            case PlanMakeViewMode.save:
              setViewMode(PlanMakeViewMode.home);
              break;
            case PlanMakeViewMode.result:
              setViewMode(PlanMakeViewMode.save);
              break;
            default:
              return true;
          }
          return false;
        });
  }

  Widget buildPage() {
    switch (viewMode) {
      case PlanMakeViewMode.calendar:
        return PlanMakeCalendarView(
          navigator: navigatorFactory(forward: PlanMakeViewMode.home),
        );
      case PlanMakeViewMode.home:
        return PlanMakeHomeView(
          navigator: navigatorFactory(
            backward: PlanMakeViewMode.calendar,
            forward: PlanMakeViewMode.save,
          ),
        );
      case PlanMakeViewMode.select:
        return PlanMakeSelectView(
          navigator: navigatorFactory(backward: PlanMakeViewMode.home),
        );
      case PlanMakeViewMode.save:
        return PlanmakeSaveView(
          navigator: navigatorFactory(
            backward: PlanMakeViewMode.home,
            forward: PlanMakeViewMode.result,
          ),
        );
      case PlanMakeViewMode.result:
        return PlanSavedView(
          navigator: navigatorFactory(
            backward: PlanMakeViewMode.save,
          ),
        );
      default:
        return SizedBox();
    }
  }
}
