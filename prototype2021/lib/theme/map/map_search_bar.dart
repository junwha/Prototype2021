import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/map/content_map_model.dart';
import 'package:prototype2021/loader/google_place_loader.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'package:prototype2021/model/map/search_place_model.dart';
import 'package:prototype2021/loader/google_place_loader.dart';
import 'package:prototype2021/ui/event/event_map_view.dart';
import 'package:provider/provider.dart';

class MapSearchBar extends StatefulWidget {
  ContentMapModel locationModel;
  bool backButtonEnabled;
  Widget? leading;
  MapSearchBar(this.locationModel,
      {this.backButtonEnabled = false, this.leading});

  @override
  _MapSearchBarState createState() => _MapSearchBarState();
}

class _MapSearchBarState extends State<MapSearchBar> {
  double searchbarHeight = 45;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildChipBar(this.widget.locationModel),
        buildFloatingSearchBar(context),
      ],
    );
  }

  Widget buildChipBar(ContentMapModel locationModel) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, searchbarHeight + 10, 10, 0),
      child: SizedBox.expand(
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceEvenly,
          children: [
            this.widget.leading ?? SizedBox(),
            buildPlaceFilterChip(locationModel, "여행지", PlaceType.SPOT,
                Image.asset("assets/icons/place.png")),
            buildPlaceFilterChip(locationModel, "카페", PlaceType.CAFFEE,
                Image.asset("assets/icons/caffe.png")),
            buildPlaceFilterChip(locationModel, "음식점", PlaceType.RESTAURANT,
                Image.asset("assets/icons/restaurant.png")),
          ],
        ),
      ),
    );
  }

  Widget buildPlaceFilterChip(
      ContentMapModel locationModel, String text, String type, Image icon) {
    return PlaceFilterChip(
      leading: icon,
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

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final controller = FloatingSearchBarController();
    final _applyKey = GlobalKey<FormState>();
    double leftMargin = this.widget.backButtonEnabled ? 50 : 10;
    return Consumer(builder: (context, ContentMapModel locationModel, child) {
      return ChangeNotifierProvider(
        create: (context) => SearchPlaceModel(locationModel),
        child: Consumer(
          builder: (context, SearchPlaceModel searchModel, child) {
            return FloatingSearchBar(
                onFocusChanged: (bool isChanged) {},
                margins: EdgeInsets.fromLTRB(leftMargin, 10, 10, 10),
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
        selectedColor: Colors.grey,
        showCheckmark: false,
      ),
    );
  }
}
