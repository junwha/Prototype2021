class Calendar {
  /* 
  * 7개 열을 가진 그리드로 바로 변환될 수 있는, DateTime과 null로 이루어진 날짜 리스트를 반환합니다
  *
  * 일요일을 한 주의 시작으로 봅니다 예를 들어 어느 달의 시작이 목요일이라면, 
  * 목요일 전에 있는 weekdays만큼, 즉 4만큼의 null이 리스트의 시작에 삽입됩니다. 
  * 또한 어느 달의 끝이 수요일이라면, 수요일 후에 있는 weekdays만큼,
  * 즉 3만큼의 null이 리스트의 끝에 삽입됩니다. 
  */
  List<DateTime?> generateCalendar(int year, int month) {
    int monthStartWeekday = getMonthStartWeekday(year, month);
    int monthEndWeekday = getMonthEndWeekDay(year, month);
    int monthEndDay = getMonthEndDay(year, month);
    int numPlaceholderAtStart = monthStartWeekday % 7;
    int numPlaceholderAtEnd = (7 - (monthEndWeekday % 7 + 1));
    List<DateTime?> calendar = [
      List.generate(numPlaceholderAtStart, (_) => null),
      List.generate(monthEndDay,
          (index) => new DateTime(year, month, index + 1, 23, 59, 59)),
      List.generate(numPlaceholderAtEnd, (_) => null)
    ].expand((element) => element).toList();
    return calendar;
  }

  /* 주어진 연, 월의 1일이 어떤 요일인지를 반환합니다. 월요일이 1, 일요일이 7입니다 */
  int getMonthStartWeekday(int year, int month) {
    DateTime monthStartDate = new DateTime(year, month, 1);
    return monthStartDate.weekday;
  }

  /* 
  * 주어진 연, 월의 말일이 며칠일지를 반환합니다. 
  * 예를들어 2021, 1을 넣으면 31이 결과값으로 나옵니다 
  */
  int getMonthEndDay(int year, int month) {
    DateTime monthEndDate = month == 2
        ? new DateTime(year, month, 29)
        : new DateTime(year, month, 31);
    if (month == monthEndDate.month) {
      return month == 2 ? 29 : 31;
    } else {
      return month == 2 ? 28 : 30;
    }
  }

  /* 주어진 연, 월의 말일이 어떤 요일인지를 반환합니다. 월요일이 1, 일요일이 7입니다 */
  int getMonthEndWeekDay(int year, int month) {
    int monthEndDay = getMonthEndDay(year, month);
    DateTime monthEndDate = new DateTime(year, month, monthEndDay);
    return monthEndDate.weekday;
  }

  /* 현재 시간이 속해있는 달에 대한 generateCalendar 메서드의 결과값을 반환합니다 */
  List<DateTime?> now() {
    DateTime now = new DateTime.now();
    return generateCalendar(now.year, now.month);
  }

  /* DateTime 객체의 weekday 프로퍼티를 인자로 받으며, 
   * 받은 weekday에 맞는 한글 요일의 String을 반환합니다. 
   * 1-7 이외의 정수를 넣을 경우 빈 문자열을 반환합니다 
  */
  String getWeekdayInKorean(int weekday) {
    switch (weekday) {
      case 1:
        return '월';
      case 2:
        return "화";
      case 3:
        return "수";
      case 4:
        return "목";
      case 5:
        return "금";
      case 6:
        return "토";
      case 7:
        return "일";
      default:
        return "";
    }
  }
}
