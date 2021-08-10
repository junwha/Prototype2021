import 'dart:ffi';

import 'package:flutter/material.dart';

enum CalendarTouchPhase {
  PENDING,
  POINT,
  RANGE,
}

class PlanMakeCalendarHandler with ChangeNotifier {
  CalendarTouchPhase _phase = CalendarTouchPhase.PENDING;
  DateTime _now;
  List<DateTime?> _datePoints = [null, null];
  int? _dateDifference;

  PlanMakeCalendarHandler({required DateTime now}) : _now = now;

  CalendarTouchPhase get phase => _phase;
  void _setPhase(CalendarTouchPhase phase) => _phase = phase;
  DateTime get now => _now;
  List<DateTime?> get datePoints => _datePoints;
  int? get dateDifference => _dateDifference;

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
}
