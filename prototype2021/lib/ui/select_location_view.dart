import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/model/map/location_model.dart';
import 'package:prototype2021/theme/card.dart';
import 'package:prototype2021/theme/map/background_map.dart';
import 'package:prototype2021/theme/map/map_search_bar.dart';
import 'package:provider/provider.dart';

class SelectLocationView extends StatefulWidget {
  const SelectLocationView({Key? key}) : super(key: key);

  @override
  _SelectLocationViewState createState() => _SelectLocationViewState();
}

class _SelectLocationViewState extends State<SelectLocationView> {
  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: ChangeNotifierProvider(
        create: (context) =>
            LocationModel(center: LatLng(0, 0)), // TODO(junwha): remove center
        child: Consumer(
          builder: (context, LocationModel locationModel, child) {
            return Stack(
              children: [
                //initial position
                BackgroundMap(
                  center: locationModel.center,
                  model: locationModel,
                ), //TODO(junwha): change to dynamic location
                //buildSelectButton(maxHeight),
                buildContentInfo(locationModel.markerList.focusedLocation),
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
                  Text("컨텐츠"),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: TextButton(
                      child: Row(
                        children: [Icon(Icons.article_outlined), Text("선택 완료")],
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
            ContentsCard(
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
