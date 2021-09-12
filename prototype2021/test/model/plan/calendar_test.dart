import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:prototype2021/model/plan/calendar.dart';

@GenerateMocks([Calendar])
void main() {
  group('of tests of Calendar', testCalendar);
}

void testCalendar() {
  final Calendar calendar = new Calendar();
  group('of tests of generateCalendar', () {
    final calendars = List.generate(
        12, (index) => calendar.generateCalendar(2021, index + 1));
    test('should return a list has length divisible with 7', () {
      calendars.forEach((_calendar) {
        expect(_calendar.length % 7, 0);
      });
    });

    test('should possibly exist nulls at sides of the list', () {
      calendars.forEach((_calendar) {
        int numTypeSwitched = 0;
        Type? previousType = null;
        _calendar.forEach((element) {
          if (previousType == null) {
            if (element == null) {
              previousType = Null;
            } else {
              previousType = DateTime;
            }
          } else {
            if (previousType != element.runtimeType) {
              numTypeSwitched++;
            }
          }
        });
        expect(numTypeSwitched, lessThanOrEqualTo(2));
      });
    });
  });
}
