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
  Function(GoogleMapController) onMapCreated;
  CameraPosition? initialCameraPosition;

  BackgroundMap({
    required this.center,
    required this.markers,
    required this.onMapCreated,
    this.load = true,
    this.onCameraMove,
    this.onTap,
    this.initialCameraPosition,
  });

  @override
  _BackgroundMapState createState() => _BackgroundMapState();
}

class _BackgroundMapState extends State<BackgroundMap> {
  //Save positions of last tapped and pressed
  // LatLng? _lastTap;
  // LatLng? _lastLongPress;
  // TODO(junwha): after all test, place marks here

  @override
  Widget build(BuildContext context) {
    return !this.widget.load
        ? Text("Loading...")
        : GoogleMap(
            onMapCreated: this.widget.onMapCreated,
            initialCameraPosition: this.widget.initialCameraPosition ??
                CameraPosition(
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
