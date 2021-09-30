// import 'package:flutter_test/flutter_test.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:prototype2021/data/location.dart';
// import 'package:prototype2021/data/place_data_props.dart';
// import 'package:prototype2021/data/pseudo_place_data.dart';
// import 'package:prototype2021/loader/google_place_loader.dart';
// import 'package:prototype2021/model/map/plan_map_model.dart';

// void main() {
//   group("PlanMapModel:", testPlanMapModel);
// }

// void testPlanMapModel() {
//   List<PlaceDataProps> data = [
//     PseudoPlaceData(
//         location: LatLng(0, 0),
//         name: "cafe",
//         types: PlaceType.CAFE,
//         address: null),
//     PseudoPlaceData(
//         location: LatLng(0, 3),
//         name: "spot",
//         types: PlaceType.SPOT,
//         address: null),
//     PseudoPlaceData(
//         location: LatLng(0, 2),
//         name: "restaurant",
//         types: PlaceType.RESTAURANT,
//         address: null),
//     PseudoPlaceData(
//         location: LatLng(3, 0),
//         name: "hotel",
//         types: PlaceType.HOTEL,
//         address: null)
//   ];

//   test('update polyline', () async {
//     final model = PlanMapModel(LatLng(0, 0));
//     await model.markerList.loadImage();
//     // polyline is null at the initial point
//     expect(model.polyline, null);
//     model.updatePolyline([]);
//     expect(model.polyline, null);

//     // Update polyline with one event location
//     model.updatePolyline([
//       PseudoPlaceData(
//           location: LatLng(3, 0),
//           name: "nontype",
//           types: PlaceType.EVENT,
//           address: null)
//     ]);
//     // polyline is null if data is only one
//     expect(1, model.locations.length);
//     expect(model.polyline, null);

//     // expect same length between data and points of polyline if data is newly added
//     model.updatePolyline(data);
//     expect(model.polyline != null, true);
//     expect(model.polyline!.points.length, data.length);

//     // All data have to be saved as IndexLocation
//     expect(
//         model.locations.map((e) => e is IndexLocation).contains(false), false);

//     model.updatePolyline([]);
//     expect(model.polyline, null);
//   });
// }
