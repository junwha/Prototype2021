import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/event_map_model.dart';
import 'package:prototype2021/theme/map/background_map.dart';
import 'package:provider/provider.dart';

class EventMapView extends StatefulWidget {
  const EventMapView({Key? key}) : super(key: key);

  @override
  _EventMapViewState createState() => _EventMapViewState();
}

class _EventMapViewState extends State<EventMapView> {
  //initial position
  LatLng? center; //TODO(junwha): change to dynamic location

  @override
  void initState() {
    initLocation();
  }

  void initLocation() async {
    LatLng savedCenter = await Geolocator.getCurrentPosition()
        .then((value) => LatLng(value.latitude, value.longitude));
    print(savedCenter);
    setState(() {
      center = savedCenter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: center == null
          ? Text("Loading")
          : ChangeNotifierProvider(
              create: (context) => EventMapModel(center: center!),
              child: Consumer(
                builder: (context, EventMapModel mapModel, child) {
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
                          mapModel.mapController = controller;
                        },
                      ), //TODO(junwha): change to dynamic location
                    ],
                  );
                },
              ),
            ),
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
