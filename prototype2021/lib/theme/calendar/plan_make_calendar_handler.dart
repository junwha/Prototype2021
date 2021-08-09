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

  PlanMakeCalendarHandler({required DateTime now}) : _now = now;

  CalendarTouchPhase get phase => _phase;
  void _setPhase(CalendarTouchPhase phase) => _phase = phase;
  DateTime get now => _now;

  void handleTap(DateTime tappedDate) {
    switch (_phase) {
      case CalendarTouchPhase.PENDING:
        _pointPhase(tappedDate);
        break;
      case CalendarTouchPhase.POINT:
        _rangePhase(tappedDate);
        break;
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
    notifyListeners();
  }

  void _pointPhase(DateTime tappedDate) {
    _setPhase(CalendarTouchPhase.POINT);
    _datePoints = [tappedDate, null];
    notifyListeners();
  }

  void _rangePhase(DateTime tappedDate) {
    _setPhase(CalendarTouchPhase.RANGE);
    _datePoints[1] = tappedDate;
    notifyListeners();
  }
}
