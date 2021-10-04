import 'package:flutter/material.dart';
import 'package:prototype2021/handler/board/plan/plan_make_calendar_handler.dart';
import 'package:prototype2021/views/board/plan/make/calendar/plan_make_calendar.dart';
import 'package:provider/provider.dart';

enum PlanMakeViewMode {
  /// 기간을 정하는 달력 화면입나다
  calendar,

  /// [PlanMakeViewMode.calendar] 다음에 나오는 화면
  /// 기간을 정하고 나면 여행 일정 짜기 화면입니다
  home,

  /// [PlanMakeViewMode.home] 에 있는 일정 리스트에서 + 버튼을 누르면 나오는 화면
  /// 검색, 저장 목록, 요즘 뜨는 플랜, 컨텐츠를 볼 수 있다
  select,

  /// [PlanMakeViewMode.select] 에서 저장한 플랜, 저장한 컨텐츠를 누르면 나오는 화면이다
  /// [BoardMainView] 위젯을 사용한다
  saved,

  /// [PlanMakeViewMode.select] 에서 검색 바를 누르면 나오는 화면이다
  /// [BoardMainView] 위젯을 사용한다
  search,
}

class PlanMakeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return ChangeNotifierProvider(
        create: (_) => PlanMakeCalendarHandler(now: now),
        child: PlanMakeCalendar());
  }
}
