import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prototype2021/theme/board/app_bar.dart';
import 'package:prototype2021/theme/board/header_silver.dart';
import 'package:prototype2021/theme/board/helpers.dart';
import 'package:prototype2021/theme/board/search_logic.dart';
import 'package:prototype2021/theme/board/search_widget.dart';
import 'package:prototype2021/theme/board/stream_list.dart';
import 'package:prototype2021/theme/cards/contents_card.dart';
import 'package:prototype2021/theme/cards/contents_card_base.dart';
import 'package:prototype2021/theme/cards/product_card.dart';
import 'package:prototype2021/theme/cards/product_card_base.dart';
import 'package:prototype2021/ui/board/content_detail_view.dart';
import 'package:prototype2021/ui/board/plan_make_view.dart';
import 'package:prototype2021/ui/board/select_location_toggle_view.dart';

const double _toolbarHeight = 60;

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
        BoardMainViewSearchWidgetMixin,
        BoardMainViewSearchLogicMixin,
        BoardMainViewHelpers {
  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

  BoardMainViewMode viewMode = BoardMainViewMode.main;

  Future<void> setViewMode(BoardMainViewMode _viewMode) async {
    handleModeChange(_viewMode);
    setState(() {
      viewMode = _viewMode;
    });
  }

  String searchInput = "";
  void setSearchInput(String _searchInput) => setState(() {
        searchInput = _searchInput;
      });
  // The types inside Lists are temporary implementation.
  // If needed, this types can be changed.
  StreamController<List<ProductCardBaseProps>> planDataController =
      new StreamController<List<ProductCardBaseProps>>.broadcast();
  StreamController<List<ContentsCardBaseProps>> contentsDataController =
      new StreamController<List<ContentsCardBaseProps>>.broadcast();

  late Stream<List<ProductCardBaseProps>> planDataStream;
  late Stream<List<ContentsCardBaseProps>> contentsDataStream;
  late Stream<List<dynamic>> recentSearchesStream;

  Future<void> pseudoApiCall() async {
    planDataController.add([]);
    contentsDataController.add([]);
    planDataController.add(await getPseudoPlanData());
    contentsDataController.add(await getPseudoContentData());
  }

  Future<void> searchOnSubmitted(String? keyword) async {
    if (keyword != null && keyword.length > 0) {
      await addSearchKeyword(keyword);
      setViewMode(BoardMainViewMode.result);
      // Do something with keyword (e.g. API call)
      // Code below is just a simulation of api call
    }
  }

  Future<void> onResetButtonPressed() async {
    await resetSearchKeyword();
    loadSearchKeywords();
  }

  Future<void> initData() async => await pseudoApiCall();

  void handleModeChange(BoardMainViewMode _viewMode) {
    if (_viewMode == BoardMainViewMode.search) {
      loadSearchKeywords();
    } else {
      pseudoApiCall();
    }
  }

  // Need Refactor
  Map<String, String> location = {"mainLocation": "국내", "subLocation": "전체"};
  // Need to apply at the level of individual cards
  bool heartSelected = false;
  bool heartSelected2 = false;

  /* =================================/================================= */
  /* =================CONSTRUCTORS & LIFE CYCLE METHODS================= */
  /* =================================/================================= */

  _BoardMainViewState() {
    planDataStream = planDataController.stream;
    contentsDataStream = contentsDataController.stream;
    recentSearchesStream = recentSearchController.stream;
  }

  @override
  void initState() {
    super.initState();
    // Code below is a simulation of api call
    initData();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    recentSearchController.close();
    planDataController.close();
    contentsDataController.close();
  }

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

  @override
  Widget build(BuildContext context) {
    bool onSearch = viewMode == BoardMainViewMode.search;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
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

  PreferredSize buildAppBar(BuildContext context) {
    return PreferredSize(
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          leading: buildLeading(context,
              viewMode: viewMode, setViewMode: setViewMode),
          title: buildTextField(
            textEditingController,
            viewMode: viewMode,
            onChanged: setSearchInput,
            setViewMode: setViewMode,
            onSubmitted: searchOnSubmitted,
          ),
          toolbarHeight: _toolbarHeight,
          actions: buildActions(setViewMode: setViewMode, viewMode: viewMode),
        ),
        preferredSize: Size.fromHeight(_toolbarHeight));
  }

  TabBarView buildDefaultBody(BuildContext context) {
    return TabBarView(children: [
      buildPlanListView(context),
      buildContentListView(context),
    ]);
  }

  Container buildSearchBody() {
    return Container(
        padding: EdgeInsets.only(right: 20, left: 40, top: 20, bottom: 20),
        child: BoardMainViewStreamList(
            stream: recentSearchController.stream,
            refetch: () => loadSearchKeywords(),
            header: buildSearchBodyHeader(),
            emptyWidget: buildCenterNotice('최근 검색기록이 없습니다'),
            errorWidget: buildCenterNotice('예기치 못한 오류가 발생했습니다'),
            builder: (recentSearch) {
              if (recentSearch is String)
                return buildRecentSearchItem(
                    text: recentSearch,
                    onActionPressed: () {
                      removeSearchKeyword(recentSearch);
                    });
              else
                return SizedBox();
            }));
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

  List<TextButton>? buildPersistentFooterButtons({required bool onSearch}) {
    if (onSearch) {
      return [
        TextButton(
            onPressed: onResetButtonPressed,
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
      return null;
    }
  }

  BoardMainViewStreamList buildPlanListView(BuildContext context) {
    return BoardMainViewStreamList<ProductCardBaseProps>(
      stream: planDataController.stream,
      refetch: () async => planDataController.add(await getPseudoPlanData()),
      builder: (props) => ProductCard(props: props),
      routeBuilder: (_) => PlanMakeView(),
    );
  }

  BoardMainViewStreamList buildContentListView(BuildContext context) {
    return BoardMainViewStreamList<ContentsCardBaseProps>(
        stream: contentsDataController.stream,
        refetch: () async =>
            contentsDataController.add(await getPseudoContentData()),
        builder: (props) => ContentsCard(props: props),
        routeBuilder: (_) => ContentDetailView());
  }
}
