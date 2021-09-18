import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/map/plan_map_model.dart';
import 'package:prototype2021/theme/calendar/plan_list_item.dart';
import 'package:prototype2021/theme/map/background_map.dart';
import 'package:provider/provider.dart';

class PlanMap extends StatefulWidget {
  PlanMap({Key? key}) : super(key: key);

  @override
  _PlanMapState createState() => _PlanMapState();
}

class _PlanMapState extends State<PlanMap> {
  @override
  Widget build(BuildContext context) {
    PlanMapModel model = Provider.of<PlanMapModel>(context);
    return BackgroundMap(
      center: model.center,
      markers: model.markers,
      onMapCreated: (GoogleMapController controller) {
        model.mapController = controller;
      },
      polylines: model.polyline != null ? <Polyline>{model.polyline!} : null,
      zoom: 13,
    );
  }
}
