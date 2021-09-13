import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:prototype2021/model/plan/plan_make_calendar_model.dart';

@GenerateMocks([PlanMakeCalendarModel])
void main(List<String> args) {
  group('[Class] PlanMakeCalendarModel', testPlanMakeCalendarModel);
}

void testPlanMakeCalendarModel() {
  final PlanMakeCalendarModel model = new PlanMakeCalendarModel();

  final DateTime firstTappedDate = new DateTime(2021, 1, 1);
  final DateTime secondTappedDate = new DateTime(2021, 1, 5);

  group('[Method] handleTap', () {
    void datePointsExpectation() {
      test('should expect datePoints as [DateTime, null] form', () {
        expect(model.datePoints[0] is DateTime, true);
        expect(model.datePoints[1], null);
      });
    }

    test('should expect initial state as PENDING', () {
      expect(model.phase, CalendarTouchPhase.PENDING);
    });

    model.handleTap(firstTappedDate);

    test('should expect POINT phase with first touch', () {
      expect(model.phase, CalendarTouchPhase.POINT);
    });

    datePointsExpectation();

    model.handleTap(secondTappedDate);

    test(
        'should expect RANGE phase as secondly touched point is after the date of first touched one',
        () {
      expect(model.phase, CalendarTouchPhase.RANGE);
    });
    test('should expect dataPoints as List of DateTime', () {
      expect(model.datePoints[0] is DateTime, true);
      expect(model.datePoints[1] is DateTime, true);
    });

    model.handleTap(secondTappedDate);

    test('should expect POINT phase with third touch', () {
      expect(model.phase, CalendarTouchPhase.POINT);
    });

    datePointsExpectation();

    model.handleTap(firstTappedDate);

    test(
        'should expect POINT phase as touched point is earlier than first element of datePoints',
        () {
      expect(model.phase, CalendarTouchPhase.POINT);
    });

    datePointsExpectation();
    model.handleTap(secondTappedDate);
  });
}
