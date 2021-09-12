import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/map/plan_map_model.dart';
import 'package:prototype2021/theme/map/background_map.dart';
import 'package:provider/provider.dart';

class PlanMap extends StatefulWidget {
  PlanMapModel model;

  PlanMap({required this.model, Key? key}) : super(key: key);

  @override
  _PlanMapState createState() => _PlanMapState();
}

class _PlanMapState extends State<PlanMap> {
  @override
  Widget build(BuildContext context) {
    return BackgroundMap(
      center: this.widget.model.center,
      markers: this.widget.model.markers,
      onMapCreated: (GoogleMapController controller) {
        this.widget.model.mapController = controller;
      },
      polylines: this.widget.model.polyline != null
          ? <Polyline>{this.widget.model.polyline!}
          : null,
    );
  }
}
