import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prototype2021/theme/map/map_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:prototype2021/theme/cards/card.dart';
import 'package:prototype2021/theme/map/place_info.dart';
import 'package:prototype2021/theme/map/background_map.dart';

import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/model/map/content_location_model.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  //Save positions of last tapped and pressed
  // LatLng? _lastTap;
  // LatLng? _lastLongPress;
  // TODO(junwha): after all test, place marks here

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
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: center == null
          ? Text("Loading")
          : ChangeNotifierProvider.value(
              value: ContentLocationModel(center: center!),
              child: Consumer(
                builder: (context, ContentLocationModel locationModel, child) {
                  return Stack(
                    children: [
                      //initial position
                      BackgroundMap(
                        center: locationModel.center,
                        markers: locationModel.markers,
                        load: locationModel.mapLoaded,
                        onCameraMove: (CameraPosition cameraPostion) {
                          locationModel.updateBearing(cameraPostion.bearing);
                          locationModel.center = cameraPostion.target;
                        },
                        onTap: (LatLng pos) {
                          if (locationModel.isFocused()) {
                            locationModel.removeFocus();
                          } else {
                            locationModel.findPlace(pos);
                          }
                        },
                      ), //TODO(junwha): change to dynamic location
                      PlaceInfo(),
                      buildBackButton(context),
                      buildWriteButton(maxHeight),
                      buildContentInfo(
                          locationModel.markerList.focusedLocation),
                      MapSearchBar(locationModel, backButtonEnabled: true),
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

  Widget buildWriteButton(double maxHeight) {
    return Padding(
      padding: EdgeInsets.only(top: maxHeight - 200),
      child: Center(
        child: TextButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(Size(88, 36)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            Navigator.pushNamed(context, "editor");
          },
          child: Text("글쓰기", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget buildContentInfo(Location? location) {
    if (location != null) {
      if (location is GooglePlaceLocation) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.white,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "컨텐츠",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ),
                      child: Row(
                        children: [Icon(Icons.article_outlined), Text("글 쓰기")],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "editor",
                            arguments: {"location": location});
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Color(0xFFF3F3F3),
              child: ContentsCard(
                preview: location.preview,
                title: location.name,
                place: "TEMP",
                explanation: "TEMP",
                rating: 1,
                ratingNumbers: 5,
                tags: ["asdf"],
                clickable: false,
                margin: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
            Container(
              color: Colors.white,
              height: 30,
            ),
          ],
        );
      }
    }
    return SizedBox(height: 0);
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 0,
      centerTitle: false,
      backgroundColor: Colors.white,
      // leading: IconButton(
      //   color: Colors.white,
      //   icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      // ),
      titleSpacing: 10,
      // title: Text(
      //   '내 주변 이벤트',
      //   style: TextStyle(
      //     color: Colors.black,
      //     fontWeight: FontWeight.w900,
      //     fontSize: 20,
      //   ),
      // ),
    );
  }
}
