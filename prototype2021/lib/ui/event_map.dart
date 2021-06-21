import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:prototype2021/model/location_model.dart';
import 'package:provider/provider.dart';

class EventMap extends StatefulWidget {
  LatLng center;
  LocationModel model;

  EventMap({required this.center, required this.model});
  @override
  _EventMapState createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> {
  GoogleMapController? mapController;

  //Save positions of last tapped and pressed
  // LatLng? _lastTap;
  // LatLng? _lastLongPress;
  // TODO(junwha): after all test, place marks here

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    this.widget.model.mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return !this.widget.model.mapLoaded
        ? Text("Loading...")
        : GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              //Set initial Camera Position
              target: this.widget.model.center,
              zoom: 18.0,
            ),
            gestureRecognizers: //Gesture Detectors
                <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            markers: this.widget.model.markers,
            onCameraMove: (CameraPosition cameraPostion) {
              this.widget.model.updateBearing(cameraPostion.bearing);
              this.widget.model.center = cameraPostion.target;
            },
            onTap: (LatLng pos) {
              this.widget.model.removeFocus();
            },

            // onLongPress: (LatLng pos) {
            //   setState(() {
            //     _lastLongPress = pos;
            //     print(pos.latnotifyListenersitude);
            //     print(pos.longitude);
            //   });
            // },
          );
  }
}
