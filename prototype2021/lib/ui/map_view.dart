import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:prototype2021/theme/card.dart';
import 'package:prototype2021/theme/map/place_info.dart';
import 'package:prototype2021/theme/map/event_map.dart';

import 'package:prototype2021/model/map/search_place_model.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/model/map/location_model.dart';
import 'package:prototype2021/model/map/map_place.dart';

//initial position
const LatLng center =
    LatLng(35.5437, 129.2563); //TODO(junwha): change to dynamic location

const double searchbarHeight = 45;

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  //Save positions of last tapped and pressed
  // LatLng? _lastTap;
  // LatLng? _lastLongPress;
  // TODO(junwha): after all test, place marks here

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: ChangeNotifierProvider(
        create: (context) => LocationModel(center: center),
        child: Consumer(
          builder: (context, LocationModel locationModel, child) {
            return Stack(
              children: [
                //initial position
                EventMap(
                  center: locationModel.center,
                  model: locationModel,
                ), //TODO(junwha): change to dynamic location
                PlaceInfo(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, searchbarHeight + 10, 10, 0),
                  child: SizedBox.expand(
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceEvenly,
                      children: [
                        buildPlaceFilterChip(locationModel, "호텔",
                            PlaceType.HOTEL), // TODO: replace to event
                        buildPlaceFilterChip(
                            locationModel, "여행지", PlaceType.SPOT),
                        buildPlaceFilterChip(
                            locationModel, "카페", PlaceType.CAFFEE),
                        buildPlaceFilterChip(
                            locationModel, "음식점", PlaceType.RESTAURANT),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: maxHeight - 200),
                  child: Center(
                    child: TextButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(88, 36)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () {},
                      child: Text("글쓰기", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                buildContentInfo(locationModel.markerList.focusedLocation),

                buildFloatingSearchBar(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildContentInfo(Location? location) {
    if (location != null) {
      if (location is GoogleLocation) {
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
                    child: Row(
                      children: [Icon(Icons.article_outlined), Text("글 쓰기")],
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

  PlaceFilterChip buildPlaceFilterChip(
      LocationModel locationModel, String text, String type) {
    return PlaceFilterChip(
      leading: Icon(Icons.comment),
      text: text,
      onSelected: (bool _isSelected) {
        if (locationModel.placeLoaded) {
          setState(() {
            locationModel.isIncludeType[type] = _isSelected;
          });
          locationModel.loadPlaces();
        }
      },
      isSelected: locationModel.isIncludeType[type]!,
    );
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

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final controller = FloatingSearchBarController();
    final _applyKey = GlobalKey<FormState>();

    return Consumer(builder: (context, LocationModel locationModel, child) {
      return ChangeNotifierProvider(
        create: (context) => SearchPlaceModel(locationModel),
        child: Consumer(
          builder: (context, SearchPlaceModel searchModel, child) {
            return FloatingSearchBar(
                onFocusChanged: (bool isChanged) {},
                margins: EdgeInsets.fromLTRB(10, 10, 10, 10),
                shadowColor: Colors.transparent,
                backdropColor: Colors.transparent,
                borderRadius: BorderRadius.circular(50),
                height: searchbarHeight,
                backgroundColor: Colors.white,
                controller: controller,
                title: Row(
                  children: [
                    Icon(Icons.search),
                    Text(
                      '장소, 여행지, 카페, 음식점 검색',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                scrollPadding: const EdgeInsets.only(top: 16, bottom: 16),
                transitionDuration: const Duration(milliseconds: 1000),
                transitionCurve: Curves.easeInOut,
                physics: const BouncingScrollPhysics(),
                axisAlignment: isPortrait ? 0.0 : -1.0,
                openAxisAlignment: 0.0,
                debounceDelay: const Duration(milliseconds: 500),
                automaticallyImplyBackButton: false,
                onQueryChanged: (query) {
                  searchModel.searchPlace(query);
                  // Call your model, bloc, controller here.
                },
                // Specify a custom transition to be used for
                // animating between opened and closed stated.
                transition: CircularFloatingSearchBarTransition(),
                leadingActions: [
                  FloatingSearchBarAction.back(
                    showIfClosed: false,
                  ),
                ],
                actions: [
                  FloatingSearchBarAction.searchToClear(
                    showIfClosed: false,
                  ),
                ],
                builder: (context, transition) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: Colors.white,
                      elevation: 4.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: searchModel.resultCards,
                      ),
                    ),
                  );
                });
          },
        ),
      );
    });
  }
}

class PlaceFilterChip extends StatefulWidget {
  Widget? leading;
  String text;
  Function(bool) onSelected;
  bool isSelected;

  PlaceFilterChip(
      {this.leading,
      required this.text,
      required this.onSelected,
      required this.isSelected});

  @override
  _PlaceFilterChipState createState() => _PlaceFilterChipState();
}

class _PlaceFilterChipState extends State<PlaceFilterChip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: FilterChip(
        avatar: this.widget.leading,
        label: Text(this.widget.text),
        onSelected: this.widget.onSelected,
        selected: this.widget.isSelected,
        backgroundColor: Colors.white,
        selectedColor: Colors.blue,
        showCheckmark: false,
      ),
    );
  }
}
