import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/handler/event/event_map_handler.dart';
import 'package:prototype2021/utils/google_map/widgets/background_map.dart';
import 'package:provider/provider.dart';

class EventMapView extends StatefulWidget {
  LatLng center;
  CameraPosition initialCameraPosition;

  EventMapView({required this.center, required this.initialCameraPosition});

  @override
  _EventMapViewState createState() => _EventMapViewState();
}

class _EventMapViewState extends State<EventMapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: ScreenUtilInit(
          designSize: Size(3200, 1440),
          builder: () {
            return ChangeNotifierProvider(
              create: (context) => EventMapHandler(center: this.widget.center),
              // Test: LatLng(37.33023, -122.02367
              child: Consumer(
                builder: (context, EventMapHandler mapModel, child) {
                  return Stack(
                    children: [
                      //initial position
                      BackgroundMap(
                        center: mapModel.center,
                        markers: mapModel.markers,
                        load: mapModel.mapLoaded,
                        onCameraMove: (CameraPosition cameraPostion) {
                          mapModel.updateBearing(cameraPostion.bearing);
                          mapModel.center = cameraPostion.target;
                        },
                        onTap: (LatLng pos) {
                          if (mapModel.isFocused()) {
                            mapModel.removeFocus();
                          } else {}
                        },
                        onMapCreated: (GoogleMapController controller) {
                          if (!mapModel.mapController.isCompleted) {
                            mapModel.mapController.complete(controller);
                          }
                        },
                        initialCameraPosition:
                            this.widget.initialCameraPosition,
                      ), //TODO(junwha): change to dynamic location
                    ],
                  );
                },
              ),
            );
          }),
    );
  }

  Widget buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
      child: IconButton(
        color: Colors.white,
        icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      // toolbarHeight: 0,
      centerTitle: false,
      backgroundColor: Colors.white,
      leading: IconButton(
        color: Colors.white,
        icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      titleSpacing: 10,
      title: Text(
        '내 주변 이벤트',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
      ),
    );
  }
}
