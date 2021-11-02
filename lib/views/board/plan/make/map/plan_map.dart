import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/handler/board/plan/plan_map_handler.dart';
import 'package:prototype2021/utils/google_map/widgets/background_map.dart';
import 'package:prototype2021/widgets/buttons/selectable_text_button.dart';
import 'package:provider/provider.dart';

class PlanMap extends StatefulWidget {
  PlanMap({Key? key}) : super(key: key);

  @override
  _PlanMapState createState() => _PlanMapState();
}

class _PlanMapState extends State<PlanMap> {
  @override
  Widget build(BuildContext context) {
    PlanMapHandler model = Provider.of<PlanMapHandler>(context);
    return Column(
      children: [
        Expanded(
          child: BackgroundMap(
            center: model.center,
            markers: model.markers,
            onMapCreated: (GoogleMapController controller) {
              if (!model.mapController.isCompleted) {
                model.mapController.complete(controller);
              }
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
  Widget buildDayButtonBar(PlanMapHandler model) {
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
                    onPressed: () async {
                      await model.setDay(index + 1);
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
