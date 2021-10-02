import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/map/plan_map_model.dart';
import 'package:prototype2021/theme/calendar/plan_list_item.dart';
import 'package:prototype2021/theme/map/background_map.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';
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
    return Column(
      children: [
        Expanded(
          child: BackgroundMap(
            center: model.center,
            markers: model.markers,
            onMapCreated: (GoogleMapController controller) {
              model.mapController = controller;
            },
            polylines: model.polyline != null
                ? <Polyline>{model.polyline!}
                : Set<Polyline>(),
            zoom: 13,
          ),
        ),
        buildDayButtonBar(model)
      ],
    );
  }

  // Generate Day button by the length of place items
  Widget buildDayButtonBar(PlanMapModel model) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 60,
        child: Row(
          children: List.generate(
              model.placeItemsPerDay.length,
              (index) => TBSelectableTextButton(
                    titleName: "${index + 1}일차",
                    isChecked: model.day == index + 1,
                    onPressed: () {
                      model.setDay(index + 1);
                    },
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                  )),
        ),
      ),
    );
  }
}
