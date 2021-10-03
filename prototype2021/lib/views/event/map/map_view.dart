import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prototype2021/utils/google_map/handler/location.dart';
import 'package:prototype2021/widgets/cards/contents_card.dart';
import 'package:prototype2021/utils/google_map/widgets/map_search_bar.dart';
import 'package:prototype2021/views/event/map/event_map_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:prototype2021/widgets/maps/place_info.dart';
import 'package:prototype2021/utils/google_map/widgets/background_map.dart';

import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/handler/google_place/content_map_model.dart';

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
              value: ContentMapModel(center: center!),
              child: Consumer(
                builder: (context, ContentMapModel mapModel, child) {
                  return Stack(
                    children: [
                      //initial position
                      buildBackgroundMap(
                          mapModel), //TODO(junwha): change to dynamic location
                      PlaceInfo(),
                      buildBackButton(context),
                      buildWriteButton(maxHeight),
                      buildContentInfo(mapModel.markerList.focusedLocation),
                      buildMapSearchBar(mapModel, context),
                    ],
                  );
                },
              ),
            ),
    );
  }

  MapSearchBar buildMapSearchBar(
      ContentMapModel mapModel, BuildContext context) {
    return MapSearchBar(
      mapModel,
      backButtonEnabled: true,
      leading: PlaceFilterChip(
        leading: Image.asset("assets/icons/event.png"),
        text: "내 주변 이벤트",
        onSelected: (bool _isSelected) {
          double zoomLevel = 14.0;
          mapModel.mapController?.getZoomLevel().then((value) {
            zoomLevel = value;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventMapView(
                center: mapModel.center,
                initialCameraPosition: CameraPosition(
                  target: mapModel.center,
                  zoom: zoomLevel,
                ),
              ),
            ),
          );
        },
        isSelected: false,
      ),
    );
  }

  BackgroundMap buildBackgroundMap(ContentMapModel mapModel) {
    return BackgroundMap(
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
        } else {
          mapModel.findPlace(pos);
        }
      },
      onMapCreated: (GoogleMapController controller) {
        mapModel.mapController = controller;
      },
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
              height: 72,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "컨텐츠",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/icons/editor.png"),
                          SizedBox(
                            width: 9,
                          ),
                          Text(
                            "글 쓰기",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(85, 85, 85, 1),
                                fontWeight: FontWeight.bold),
                          )
                        ],
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
              child: ContentsCard.fromProps(
                props: new ContentsCardBaseProps(
                  hearted: false,
                  heartCount: 3,
                  id: 0,
                  preview: location.preview,
                  title: location.name,
                  place: "TEMP",
                  explanation: "TEMP",
                  rating: 1,
                  ratingNumbers: 5,
                  tags: ["액티비티", "인생사진", "sns핫플"],
                  margin: const EdgeInsets.symmetric(vertical: 0),
                ),
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
