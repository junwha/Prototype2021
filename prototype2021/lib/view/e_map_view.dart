import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:prototype2021/model/location_model.dart';
import 'package:provider/provider.dart';
import 'package:prototype2021/ui/event_map.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? mapController;

  //initial position
  LatLng center =
      LatLng(37.5172, 127.0473); //TODO(junwha): change to dynamic location

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
        toolbarHeight: 50,
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
        create: (context) => LocationModel(center: center),
        child: Stack(
          children: [
            //initial position
            EventMap(
              center: center,
            ), //TODO(junwha): change to dynamic location
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedContainer(
                  color: Colors.white,
                  width: double.maxFinite,
                  height: 150,
                  child: Column(
                    children: [
                      Text("이 장소가 언급된 글"),
                    ],
                  ),
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
