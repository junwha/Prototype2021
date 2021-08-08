import 'package:flutter/material.dart';

enum CalendarTouchPhase {
  PENDING,
  POINT,
  RANGE,
}

class CalendarHandler with ChangeNotifier {
  CalendarTouchPhase _phase = CalendarTouchPhase.PENDING;

  CalendarTouchPhase getPhase() => _phase;
  void setPhase(CalendarTouchPhase phase) => _phase = phase;

  void togglePhase() {
    switch (_phase) {
      case CalendarTouchPhase.PENDING:
        setPhase(CalendarTouchPhase.POINT);
        break;
      case CalendarTouchPhase.POINT:
        setPhase(CalendarTouchPhase.RANGE);
        break;
      case CalendarTouchPhase.RANGE:
        setPhase(CalendarTouchPhase.POINT);
        break;
      default:
        setPhase(CalendarTouchPhase.PENDING);
        break;
    }
  }

  void resetPhase() {
    setPhase(CalendarTouchPhase.PENDING);
  }
}
