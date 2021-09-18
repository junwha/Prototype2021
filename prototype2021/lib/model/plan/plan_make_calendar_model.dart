import 'package:flutter/material.dart';
import 'package:prototype2021/data/place_data_props.dart';

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

class PlanMakeCalendarModel with ChangeNotifier {
  CalendarTouchPhase _phase = CalendarTouchPhase.PENDING;
  DateTime _now;
  List<DateTime?> _datePoints = [null, null];
  int? _dateDifference;
  List<List<PlaceDataProps>>? _planListItems;

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
   * 리스트 안에 있는 리스트들은 여행 시작 날짜에서부터 순서대로 그 날짜의 여행 계획으로 이루어집니다  
  */
  List<List<PlaceDataProps>>? get planListItems => _planListItems;

  /*
   * 여행 계획들을 순서를 유지하면서 평탄화하여 리턴합니다
   */
  List<PlaceDataProps> get flattenPlanListItems {
    List<PlaceDataProps> _flattenPlanListItems = [];
    if (_planListItems == null) return _flattenPlanListItems;

    for (List<PlaceDataProps> itemList in _planListItems!) {
      _flattenPlanListItems.addAll(itemList);
    }

    return _flattenPlanListItems;
  }

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

  void generatePlanListItems() {
    _planListItems = List.generate(dateDifference!, (_) => []);
    notifyListeners();
  }

  void resetPlanListItems() => generatePlanListItems();

  void addPlaceData(int index, PlaceDataProps data) {
    _planListItems![index].add(data);
    notifyListeners();
  }

  void deletePlaceData(int index, int order) {
    _planListItems![index].removeAt(order - 1);
    notifyListeners();
  }

  int _validateIndex(int index, int indexToValidate) {
    int validIndex;
    if (indexToValidate <= 0) {
      validIndex = 0;
    } else if (indexToValidate > 0 && index < _planListItems![index].length) {
      validIndex = indexToValidate;
    } else {
      validIndex = _planListItems![index].length - 1;
    }
    return validIndex;
  }

  void swapPlaceData(int index, int oldIndex, int newIndex) {
    int validNewIndex = _validateIndex(index, newIndex);
    final PlaceDataProps temp = _planListItems![index].removeAt(oldIndex);
    _planListItems![index].insert(validNewIndex, temp);
    notifyListeners();
  }

  void insertPlaceData(int index, PlaceDataProps data, int indexToInsert) {
    int validIndexToInsert = _validateIndex(index, indexToInsert);
    _planListItems![index].insert(validIndexToInsert, data);
  }
}
