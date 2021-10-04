import 'package:flutter/material.dart';
import 'package:prototype2021/handler/board/plan/plan_make_calendar_handler.dart';
import 'package:prototype2021/views/board/plan/make/calendar/plan_make_calendar.dart';
import 'package:prototype2021/views/board/plan/make/home/plan_make_home_view.dart';
import 'package:provider/provider.dart';

enum Navigate {
  backward,
  forward,
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

class PlanMakeView extends StatefulWidget {
  const PlanMakeView();

  _PlanMakeViewState createState() => _PlanMakeViewState();
}

class _PlanMakeViewState extends State<PlanMakeView> {
  PlanMakeViewMode viewMode = PlanMakeViewMode.calendar;
  void setViewMode(PlanMakeViewMode _viewMode) => setState(() {
        viewMode = _viewMode;
      });
  void Function(Navigate) navigatorFactory({
    PlanMakeViewMode? backward,
    PlanMakeViewMode? forward,
  }) {
    return (Navigate navigateDirection) {
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
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return ChangeNotifierProvider(
      create: (_) => PlanMakeCalendarHandler(now: now),
      child: buildPage(),
    );
  }

  Widget buildPage() {
    switch (viewMode) {
      case PlanMakeViewMode.calendar:
        return PlanMakeCalendar(
          navigator: navigatorFactory(forward: PlanMakeViewMode.home),
        );
      case PlanMakeViewMode.home:
        return PlanMakeHomeView(
          navigator: navigatorFactory(
            backward: PlanMakeViewMode.calendar,
            forward: PlanMakeViewMode.select,
          ),
        );
      default:
        return SizedBox();
    }
  }
}
