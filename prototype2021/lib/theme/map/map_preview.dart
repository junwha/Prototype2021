import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/model/map/location_model.dart';
import 'package:prototype2021/model/map/map_place.dart';
import 'package:prototype2021/theme/map/marker.dart';

class MapPreview extends StatefulWidget {
  Location location;

  MapPreview({required this.location});
  @override
  _MapPreviewState createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  GoogleMapController? mapController;

  //Save positions of last tapped and pressed
  // LatLng? _lastTap;
  // LatLng? _lastLongPress;
  // TODO(junwha): after all test, place marks here
  MarkerList markerList = MarkerList();
  bool isLoaded = true;
  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  @override
  void initState() {
    load();
  }

  void load() async {
    // TODO(junwha): locaiton model 상속으로 GooglePlace 관련 메소드 분리하기
    isLoaded = await markerList.loadImage();
    setState(() {
      markerList.addMarker(
          Location(this.widget.location.latLng, PlaceType.DEFAULT, "T"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? Text("Loading...")
        : SizedBox(
            height: 200,
            child: GoogleMap(
              zoomControlsEnabled: false,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: false,
              tiltGesturesEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                //Set initial Camera Position
                target: this.widget.location.latLng,
                zoom: 15.0,
              ),
              gestureRecognizers: //Gesture Detectors
                  <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              markers: markerList.markerList,
            ),
          );
  }
}
