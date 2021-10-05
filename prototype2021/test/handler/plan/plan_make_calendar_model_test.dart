import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/model/board/place_data_props.dart';
import 'package:prototype2021/model/board/pseudo_place_data.dart';
import 'package:prototype2021/handler/board/plan/plan_make_calendar_handler.dart';

@GenerateMocks([PlanMakeCalendarHandler])
void main() {
  group('[Class] PlanMakeCalendarModel', testPlanMakeCalendarModel);
}

void testPlanMakeCalendarModel() {
  final DateTime firstTappedDate = new DateTime(2021, 1, 1);
  final DateTime secondTappedDate = new DateTime(2021, 1, 5);
  final int dateDifference = 5;

  final List<PlaceDataInterface> dataSamples = [
    new PseudoPlaceData(
      location: new LatLng(0.0, 0.0),
      name: 'test1',
      types: 'cafe',
      id: 1,
      contentType: ContentType.restaurants,
      address: 'testtesttest',
    ),
    new PseudoPlaceData(
      location: new LatLng(0.1, 0.1),
      name: 'test2',
      types: 'cafe',
      id: 2,
      contentType: ContentType.restaurants,
      address: 'testtesttest',
    ),
    new PseudoPlaceData(
      location: new LatLng(0.2, 0.2),
      name: 'test3',
      types: 'cafe',
      id: 3,
      contentType: ContentType.restaurants,
      address: 'testtesttest',
    ),
  ];
  final int dataListIndex = 0;

  group('[Method] handleTap', () {
    final PlanMakeCalendarHandler model = new PlanMakeCalendarHandler();
    test('should expect initial state as PENDING', () {
      expect(model.phase, CalendarTouchPhase.PENDING);
    });

    test('should expect POINT phase with first touch', () {
      model.handleTap(firstTappedDate);
      expect(model.phase, CalendarTouchPhase.POINT);
    });

    test('should expect datePoints as [DateTime, null] form', () {
      expect(model.datePoints[0] is DateTime, true);
      expect(model.datePoints[1] == null, true);
    });

    test(
        'should expect RANGE phase as secondly touched point is after the date of first touched one',
        () {
      model.handleTap(secondTappedDate);
      expect(model.phase, CalendarTouchPhase.RANGE);
    });
    test('should expect dataPoints as List of DateTime', () {
      expect(model.datePoints[0] is DateTime, true);
      expect(model.datePoints[1] is DateTime, true);
    });

    test('should expect POINT phase with third touch', () {
      model.handleTap(secondTappedDate);
      expect(model.phase, CalendarTouchPhase.POINT);
    });

    test(
        'should expect POINT phase as touched point is earlier than first element of datePoints',
        () {
      model.handleTap(firstTappedDate);
      expect(model.phase, CalendarTouchPhase.POINT);
    });
  });

  group('[Property] dateDifference', () {
    final PlanMakeCalendarHandler model = new PlanMakeCalendarHandler();

    test('should return 1 if the phase is POINT', () {
      model.handleTap(firstTappedDate);
      expect(model.dateDifference, 1);
    });
    test('should return a date difference including edges', () {
      model.handleTap(secondTappedDate);
      expect(model.dateDifference, dateDifference);
      expect(model.dateDifference is int, true);
    });
  });
  group('[Method] generatePlanListItems', () {
    final PlanMakeCalendarHandler model = new PlanMakeCalendarHandler();

    model.handleTap(firstTappedDate);
    model.handleTap(secondTappedDate);
    test('should set planListItems as a list of empty lists', () {
      print(model);
      model.generatePlanListItems();
      model.planListItems?.forEach((element) {
        expect(element is List, true);
      });
    });
    test('should set the list with length of date difference', () {
      expect(model.planListItems?.length, dateDifference);
    });
  });

  group('[Method] addPlaceData', () {
    final PlanMakeCalendarHandler model = new PlanMakeCalendarHandler();

    model.handleTap(firstTappedDate);
    model.handleTap(secondTappedDate);
    model.generatePlanListItems();
    test('should add the data to planListItem as nested', () {
      model.addPlaceData(dataListIndex, dataSamples[0]);
      expect(model.planListItems![dataListIndex].length, 1);
    });
  });

  group('[Method] deletePlaceData', () {
    final PlanMakeCalendarHandler model = new PlanMakeCalendarHandler();

    model.handleTap(firstTappedDate);
    model.handleTap(secondTappedDate);
    model.generatePlanListItems();
    model.addPlaceData(dataListIndex, dataSamples[0]);

    test('should delete the data from planListItem from nested list', () {
      int order = 1; // Item added above test: order is 1
      model.deletePlaceData(dataListIndex, order);
      expect(model.planListItems![dataListIndex].length, 0);
    });
  });

  group('[Method] swapPlaceData', () {
    final PlanMakeCalendarHandler model = new PlanMakeCalendarHandler();

    model.handleTap(firstTappedDate);
    model.handleTap(secondTappedDate);
    model.generatePlanListItems();
    test('should move data from oldIndex to newList', () {
      model.addPlaceData(dataListIndex, dataSamples[0]);
      model.addPlaceData(dataListIndex, dataSamples[1]);
      expect(model.planListItems![dataListIndex][0].name, 'test1');
      expect(model.planListItems![dataListIndex][1].name, 'test2');

      model.swapPlaceData(dataListIndex, 0, 1);

      expect(model.planListItems![dataListIndex][0].name, 'test2');
      expect(model.planListItems![dataListIndex][1].name, 'test1');
    });
  });

  group('[Method] insertPlaceData', () {
    final PlanMakeCalendarHandler model = new PlanMakeCalendarHandler();

    model.handleTap(firstTappedDate);
    model.handleTap(secondTappedDate);
    model.generatePlanListItems();
    model.addPlaceData(dataListIndex, dataSamples[0]);
    model.addPlaceData(dataListIndex, dataSamples[1]);
    test('should insert data betweeen items', () {
      model.insertPlaceData(dataListIndex, dataSamples[2], 1);
      expect(model.planListItems![dataListIndex][1].name, 'test3');
    });
  });

  /*
   * - Private methods are not tested
   * - resetPlanListItems is equivalent to generatePlanListItems
   * - inherit is not tested since it's very simple function
   */
}
