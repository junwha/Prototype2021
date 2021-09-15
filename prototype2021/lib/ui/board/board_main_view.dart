import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prototype2021/theme/board/app_bar.dart';
import 'package:prototype2021/theme/board/header_silver.dart';
import 'package:prototype2021/theme/board/helpers.dart';
import 'package:prototype2021/theme/board/search_logic.dart';
import 'package:prototype2021/theme/board/stream_list.dart';
import 'package:prototype2021/theme/cards/contents_card.dart';
import 'package:prototype2021/theme/cards/contents_card_base.dart';
import 'package:prototype2021/theme/cards/product_card.dart';
import 'package:prototype2021/theme/cards/product_card_base.dart';
import 'package:prototype2021/ui/board/content_detail_view.dart';
import 'package:prototype2021/ui/board/plan_make_view.dart';
import 'package:prototype2021/ui/board/select_location_toggle_view.dart';

class BoardMainView extends StatefulWidget {
  const BoardMainView({Key? key}) : super(key: key);

  @override
  _BoardMainViewState createState() => _BoardMainViewState();
}

enum BoardMainViewMode { main, search, result }

class _BoardMainViewState extends State<BoardMainView>
    with
        BoardMainHeaderSilverMixin,
        BoardMainViewAppBarMixin,
        BoardMainViewStreamListMixin,
        BoardMainViewSearchLogicMixin,
        BoardMainViewHelpers {
  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

  BoardMainViewMode viewMode = BoardMainViewMode.main;

  void setViewMode(BoardMainViewMode _viewMode) => setState(() {
        viewMode = _viewMode;
      });

  String searchInput = "";
  void setSearchInput(String _searchInput) => setState(() {
        searchInput = _searchInput;
      });
  // The types inside Lists are temporary implementation.
  // If needed, this types can be changed.
  StreamController<List<ProductCardBaseProps>> planDataController =
      new StreamController<List<ProductCardBaseProps>>();
  StreamController<List<ContentsCardBaseProps>> contentsDataController =
      new StreamController<List<ContentsCardBaseProps>>();

  Future<void> searchOnSubmitted(String keyword) async {
    setViewMode(BoardMainViewMode.result);
    addSearchKeyword(keyword);
    // Do something with keyword (e.g. API call)
    // Code below is just a simulation of api call
    planDataController.add([]);
    contentsDataController.add([]);
    planDataController.add(await getPseudoPlanData());
    contentsDataController.add(await getPseudoContentData());
  }

  // Need Refactor
  Map<String, String> location = {"mainLocation": "국내", "subLocation": "전체"};
  // Need to apply individual cards
  bool heartSelected = false;
  bool heartSelected2 = false;

  /* =================================/================================= */
  /* =================CONSTRUCTORS & LIFE CYCLE METHODS================= */
  /* =================================/================================= */

  _BoardMainViewState() : super();

  @override
  void initState() async {
    super.initState();
    // Code below is a simulation of api call
    planDataController.add(await getPseudoPlanData());
    contentsDataController.add(await getPseudoContentData());
  }

  @override
  void didUpdateWidget(BoardMainView oldWidget) async {
    super.didUpdateWidget(oldWidget);
    if (viewMode == BoardMainViewMode.search) {
      List<String>? recentSearches = await getSearchKeywords();
      if (recentSearches == null || recentSearches.length == 0)
        recentSearchController.add([]);
      else
        recentSearchController.add(recentSearches);
    }
  }

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

  @override
  Widget build(BuildContext context) {
    bool onSearch = viewMode == BoardMainViewMode.search;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context,
            viewMode: viewMode,
            setViewMode: setViewMode,
            textController: textEditingController,
            onTextFieldChanged: setSearchInput),
        body: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: NestedScrollView(
              headerSliverBuilder: buildHeaderBuilder(context),
              body: onSearch ? buildSearchBody() : buildDefaultBody(context)),
        ),
        persistentFooterButtons:
            buildPersistentFooterButtons(onSearch: onSearch));
  }

  TabBarView buildDefaultBody(BuildContext context) {
    return TabBarView(children: [
      buildPlanListView(context),
      buildContentListView(context),
    ]);
  }

  Container buildSearchBody() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: buildStreamListView<String>(context,
            stream: recentSearchController.stream,
            builder: (recentSearch) => Container(
                  child: Row(
                    children: [
                      Text(recentSearch,
                          style: const TextStyle(
                              color: const Color(0xff555555),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0),
                          textAlign: TextAlign.left),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.cancel,
                              color: const Color(0xffdadada))),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                )));
  }

  List<SliverAppBar> Function(BuildContext, bool) buildHeaderBuilder(
      BuildContext context) {
    // Need Refactor
    void onLeadingPressed() {
      Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (context) => SelectLocationToggleView(
                    mainLocation: location["mainLocation"] ?? "",
                    subLocation: location["subLocation"] ?? "",
                  ))).then((value) {
        setState(() {
          Map<String, String> _location = value as Map<String, String>;
          if (_location.containsKey("mainLocation") &&
              _location.containsKey("subLocation")) {
            location = _location;
          }
        });
      });
    }

    return buildHeaderSilverBuilder(
        location: location,
        onLeadingPressed: onLeadingPressed,
        viewMode: viewMode);
  }

  List<TextButton> buildPersistentFooterButtons({required bool onSearch}) {
    if (onSearch) {
      return [
        TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Icon(Icons.delete_forever, color: const Color(0xff555555)),
                SizedBox(width: 7),
                Text("전체 삭제",
                    style: const TextStyle(
                        color: const Color(0xff555555),
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto",
                        fontStyle: FontStyle.normal,
                        fontSize: 15.0),
                    textAlign: TextAlign.center)
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ))
      ];
    } else {
      return [];
    }
  }

  StreamBuilder buildPlanListView(BuildContext context) {
    return buildStreamListView<ProductCardBaseProps>(
      context,
      stream: planDataController.stream,
      builder: (props) => ProductCard(props: props),
      routeBuilder: (_) => PlanMakeView(),
    );
  }

  StreamBuilder buildContentListView(BuildContext context) {
    return buildStreamListView<ContentsCardBaseProps>(context,
        stream: contentsDataController.stream,
        builder: (props) => ContentsCard(props: props),
        routeBuilder: (_) => ContentDetailView());
  }
}
