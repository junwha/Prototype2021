import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:prototype2021/model/plan/calendar.dart';

@GenerateMocks([Calendar])
void main() {
  group('[Class] Calendar', testCalendar);
}

void testCalendar() {
  group('[Method] generateCalendar', () {
    final Calendar calendar = new Calendar();
    final calendars = List.generate(
        12, (index) => calendar.generateCalendar(2021, index + 1));
    test('should return a list has length divisible with 7', () {
      calendars.forEach((_calendar) {
        expect(_calendar.length % 7, 0);
      });
    });

    test('should return a list consists of null and DateTime', () {
      calendars.forEach((_calendar) {
        _calendar.forEach((element) {
          expect(element == null || element is DateTime, true);
        });
      });
    });

    test('should return a list with lte 2 times of type changes', () {
      calendars.forEach((_calendar) {
        int numTypeSwitched = 0;
        DateTime? prevElement;
        _calendar.forEach((element) {
          if (prevElement == null && element != null) {
            numTypeSwitched++;
          }
          if (prevElement != null && element == null) {
            numTypeSwitched++;
          }
          prevElement = element;
        });
        expect(numTypeSwitched, lessThanOrEqualTo(2));
      });
    });
  });

  group('[Method] getMonthEndDay', () {
    final Calendar calendar = new Calendar();
    int normalYear = 2021;
    int leapYear = 2020;
    test('should get month end day according to month', () {
      expect(calendar.getMonthEndDay(normalYear, 1), 31);
      expect(calendar.getMonthEndDay(normalYear, 2), 28);
      expect(calendar.getMonthEndDay(leapYear, 2), 29);
      expect(calendar.getMonthEndDay(normalYear, 4), 30);
    });
  });

  group('[Static Method] dateToString', () {
    DateTime birth = new DateTime(2002, 12, 09);
    String birthToString = '2002-12-09';

    test('should get date to string in format that can satisfy the API', () {
      expect(Calendar.dateToString(birth), birthToString);
    });
  });

  /* 
   * These are untested methods since it's logic is too simple to test it
   * 
   * - getMonthStartWeekday
   * - getMonthEndWeekday
   * - now
   * - getWeekdayInKorean
  */
}
