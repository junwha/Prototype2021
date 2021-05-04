import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:prototype2021/model/location_model.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? mapController;

  //initial position
  LatLng center =
      LatLng(35.5735, 129.1896); //TODO(junwha): change to dynamic location

  //Save positions of last tapped and pressed
  // LatLng? _lastTap;
  // LatLng? _lastLongPress;
  // TODO(junwha): after all test, place marks here

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      ),
      body: ChangeNotifierProvider(
        create: (context) => LocationModel(),
        child: Consumer(builder: (contet, LocationModel locationModel, child) {
          return !locationModel.loaded
              ? Text("Loading...")
              : GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    //Set initial Camera Position
                    target: center,
                    zoom: 18.0,
                  ),
                  gestureRecognizers: //Gesture Detectors
                      <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                    ),
                  },
                  markers: locationModel.markers,
                  onCameraMove: (CameraPosition cameraPostion) {
                    locationModel.setBearing(cameraPostion.bearing);
                  },
                  // onTap: (LatLng pos) {
                  //   setState(() {
                  //     _lastTap = pos;
                  //     print("Pressed");
                  //     print(pos.latitude);
                  //     print(pos.longitude);
                  //   });
                  // },
                  // onLongPress: (LatLng pos) {
                  //   setState(() {
                  //     _lastLongPress = pos;
                  //     print(pos.latnotifyListenersitude);
                  //     print(pos.longitude);
                  //   });
                  // },
                );
        }),
      ),
    );
  }
}
