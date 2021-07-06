import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:prototype2021/model/map/content_location_model.dart';

class BackgroundMap extends StatefulWidget {
  LatLng center;
  Function(CameraPosition cameraPostion)? onCameraMove;
  Function(LatLng pos)? onTap;
  Set<Marker> markers;
  bool load;

  BackgroundMap(
      {required this.center,
      required this.markers,
      this.load = true,
      this.onCameraMove,
      this.onTap});
  @override
  _BackgroundMapState createState() => _BackgroundMapState();
}

class _BackgroundMapState extends State<BackgroundMap> {
  GoogleMapController? mapController;

  //Save positions of last tapped and pressed
  // LatLng? _lastTap;
  // LatLng? _lastLongPress;
  // TODO(junwha): after all test, place marks here

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return !this.widget.load
        ? Text("Loading...")
        : GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              //Set initial Camera Position
              target: this.widget.center,
              zoom: 18.0,
            ),
            gestureRecognizers: //Gesture Detectors
                <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            markers: this.widget.markers,
            onCameraMove: this.widget.onCameraMove,
            onTap: this.widget.onTap,
          );
  }
}
