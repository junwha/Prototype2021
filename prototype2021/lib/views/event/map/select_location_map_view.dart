import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/handler/google_place/content_map_handler.dart';
import 'package:prototype2021/utils/google_map/handler/location.dart';
import 'package:prototype2021/widgets/cards/contents_card.dart';
import 'package:prototype2021/utils/google_map/widgets/background_map.dart';
import 'package:prototype2021/utils/google_map/widgets/map_search_bar.dart';
import 'package:provider/provider.dart';

class SelectLocationMapView extends StatefulWidget {
  const SelectLocationMapView({Key? key}) : super(key: key);

  @override
  _SelectLocationMapViewState createState() => _SelectLocationMapViewState();
}

class _SelectLocationMapViewState extends State<SelectLocationMapView> {
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
          : ChangeNotifierProvider(
              create: (context) => ContentMapHandler(
                  center: center!), // TODO(junwha): remove center
              child: Consumer(
                builder: (context, ContentMapHandler locationModel, child) {
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
                          onMapCreated: (GoogleMapController controller) {
                            locationModel.mapController = controller;
                          }), //TODO(junwha): change to dynamic location
                      //buildSelectButton(maxHeight),
                      buildContentInfo(
                          locationModel.markerList.focusedLocation),
                      MapSearchBar(locationModel),
                    ],
                  );
                },
              ),
            ),
    );
  }

  Widget buildSelectButton(double maxHeight) {
    return Padding(
      padding: EdgeInsets.only(top: maxHeight - 200),
      child: Center(
        child: TextButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(Size(88, 36)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {},
          child: Text("선택 완료", style: TextStyle(color: Colors.white)),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "컨텐츠",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: TextButton(
                      child: Row(
                        children: [
                          Image.asset('assets/icons/check_outlined.png'),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "선택 완료",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          )
                        ],
                      ),
                      onPressed: () {
                        selectLoaction(location);
                      },
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            ContentsCard.fromProps(
                props: new ContentsCardBaseProps(
              hearted: false,
              heartCount: 3,
              id: 0,
              preview: location.preview,
              title: location.name,
              place: "TEMP",
              explanation: "TEMP",
              tags: ["asdf"],
              margin: const EdgeInsets.symmetric(vertical: 0),
            )),
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
        '지도 선택하기',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 20,
        ),
      ),
    );
  }

  void selectLoaction(Location location) {
    Navigator.pop(context, location);
  }
}
