import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:prototype2021/model/location_model.dart';
import 'package:prototype2021/ui/place_info.dart';
import 'package:prototype2021/ui/search_result.dart';
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
      LatLng(35.5437, 129.2563); //TODO(junwha): change to dynamic location

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
      ),
      body: ChangeNotifierProvider(
        create: (context) => LocationModel(center: center),
        child: Stack(
          children: [
            //initial position
            EventMap(
              center: center,
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
            buildFloatingSearchBar(context),
          ],
        ),
      ),
    );
  }

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final controller = FloatingSearchBarController();
    final _applyKey = GlobalKey<FormState>();

    double leftPadding = 50;

    return FloatingSearchBar(
      onFocusChanged: (bool isChanged) {
        setState(() {
          leftPadding = !isChanged ? 10 : 50;
        });
      },
      margins: EdgeInsets.fromLTRB(50, 10, 10, 10),
      shadowColor: Colors.transparent,
      backdropColor: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      height: 45,
      backgroundColor: Colors.blueGrey[700],
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
              children: Colors.accents.map((color) {
                return SearchResult("asdf");
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
