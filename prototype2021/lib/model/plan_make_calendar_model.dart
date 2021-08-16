import 'dart:ffi';

import 'package:flutter/material.dart';

/* 
* 캘린더의 터치 상태를 표현하는 enum입니다. 
* 캘린더의 터치 상태는 PENDING, POINT, RANGE로 나뉘는데, 
* PENDING은 아무 날짜도 선택되지 않았을 때, POINT는 하루만 선택되었을 때, 
* RANGE는 여러 날짜가 선택되었을 때를 의미합니다.
*/
enum CalendarTouchPhase {
  PENDING,
  POINT,
  RANGE,
}

enum PlanMakeRoute {
  CALENDAR,
  HOME,
  SEARCH,
  SAVED_LIST,
  PLAN_INFO,
  CONTENTS_INFO
}

class PlanMakeCalendarModel with ChangeNotifier {
  CalendarTouchPhase _phase = CalendarTouchPhase.PENDING;
  DateTime _now;
  List<DateTime?> _datePoints = [null, null];
  int? _dateDifference;

  PlanMakeCalendarModel({DateTime? now}) : _now = now ?? new DateTime.now();

  /* 
  * 캘린더의 터치 상태인 enum CalenderTouchPhase를 가져옵니다. 
  * 캘린더의 터치 상태는 PENDING, POINT, RANGE로 나뉘는데, 
  * PENDING은 아무 날짜도 선택되지 않았을 때, POINT는 하루만 선택되었을 때, 
  * RANGE는 여러 날짜가 선택되었을 때를 의미합니다.
  */
  CalendarTouchPhase get phase => _phase;
  void _setPhase(CalendarTouchPhase phase) => _phase = phase;
  /* 
  * constructor를 통해 넘겨진 DateTime을 반환합니다. 
  * 코드 상에서는 new DateTime.now()를 constructor에 넘기기 때문에 
  * new DateTime.now()를 반환받는다 생각하셔도 무방합니다.
  */
  DateTime get now => _now;
  /* 선택된 날짜들의 리스트를 반환합니다. null은 선택된 날짜가 없음을 의미합니다 */
  List<DateTime?> get datePoints => _datePoints;
  /* 
  * 두개의 날짜가 선택되었을 때, 두 날짜의 차이를 일 수로 반환합니다. 
  * 하나의 날짜만 선택되었을 시에는 1을 반환합니다.
  */
  int? get dateDifference => _dateDifference;

  /* 
  * 캘린더의 터치를 핸들링하는 메소드입니다. 
  * 캘린더의 상태를 관리하는 핵심적인 함수로, 사용하지 않는것을 권장합니다
  */
  void handleTap(DateTime tappedDate) {
    switch (_phase) {
      case CalendarTouchPhase.PENDING:
        _pointPhase(tappedDate);
        break;
      case CalendarTouchPhase.POINT:
        {
          if (!tappedDate.isAfter(_datePoints[0]!)) {
            _pointPhase(tappedDate);
          } else {
            _rangePhase(tappedDate);
          }
          break;
        }
      case CalendarTouchPhase.RANGE:
        _pointPhase(tappedDate);
        break;
      default:
        _resetPhase();
        break;
    }
  }

  void _resetPhase() {
    _setPhase(CalendarTouchPhase.PENDING);
    _datePoints = [null, null];
    _dateDifference = null;
    notifyListeners();
  }

  void _pointPhase(DateTime tappedDate) {
    _setPhase(CalendarTouchPhase.POINT);
    _datePoints = [tappedDate, null];
    _dateDifference = 1;
    notifyListeners();
  }

  void _rangePhase(DateTime tappedDate) {
    _setPhase(CalendarTouchPhase.RANGE);
    _datePoints[1] = tappedDate;
    _dateDifference = tappedDate.difference(_datePoints[0]!).inDays + 1;
    notifyListeners();
  }

  PlanMakeCalendarModel inherit() {
    return this;
  }
}
