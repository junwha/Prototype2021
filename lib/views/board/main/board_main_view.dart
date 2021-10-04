import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/loader/board/contents_loader.dart';
import 'package:prototype2021/model/common.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/views/board/main/mixin/app_bar.dart';
import 'package:prototype2021/views/board/main/mixin/header_silver.dart';
import 'package:prototype2021/views/board/main/mixin/helpers.dart';
import 'package:prototype2021/views/board/main/mixin/search_logic.dart';
import 'package:prototype2021/views/board/main/mixin/search_widget.dart';
import 'package:prototype2021/views/board/main/mixin/stream_list.dart';
import 'package:prototype2021/widgets/cards/contents_card.dart';
import 'package:prototype2021/widgets/cards/product_card.dart';
import 'package:prototype2021/widgets/notices/center_notice.dart';
import 'package:prototype2021/widgets/buttons/selectable_text_button.dart';
import 'package:prototype2021/views/board/content/detail/content_detail_view.dart';
import 'package:prototype2021/views/board/plan/make/plan_make_view.dart';
import 'package:prototype2021/views/board/main/location/select_location_toggle_view.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

const double _toolbarHeight = 60;

class BoardMainView extends StatefulWidget {
  const BoardMainView({Key? key}) : super(key: key);

  @override
  _BoardMainViewState createState() => _BoardMainViewState();
}

enum BoardMainViewMode { main, search, result }

class _BoardMainViewState extends State<BoardMainView>
    with
        BoardMainSilverMixin,
        BoardMainViewAppBarMixin,
        BoardMainViewSearchWidgetMixin,
        BoardMainViewSearchLogicMixin,
        BoardMainViewHelpers,
        ContentsLoader {
  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

  int refetchCount = 0;
  final int maxRefetchCount = 3;
  void setRefetchCount(int _refetchCount) => setState(() {
        refetchCount = _refetchCount;
      });

  BoardMainViewMode viewMode = BoardMainViewMode.main;

  Future<void> setViewMode(BoardMainViewMode _viewMode) async {
    setState(() {
      viewMode = _viewMode;
      refetchCount = 0;
    });
    handleModeChange(_viewMode);
  }

  String searchInput = "";
  void setSearchInput(String _searchInput) => setState(() {
        searchInput = _searchInput;
      });

  int tabIndex = 0;
  void setTabIndex(int _tabIndex) => setState(() {
        tabIndex = _tabIndex;
      });

  ContentType? currentFilter = null;
  void setCurrentFilter(ContentType? newFilter) => setState(() {
        currentFilter = newFilter;
      });

  // The types inside Lists are temporary implementation.
  // If needed, this types can be changed.
  StreamController<List<ProductCardBaseProps>> planDataController =
      new BehaviorSubject<List<ProductCardBaseProps>>();
  StreamController<List<ContentsCardBaseProps>> contentsDataController =
      new BehaviorSubject<List<ContentsCardBaseProps>>();

  late Stream<List<ProductCardBaseProps>> planDataStream;
  late Stream<List<ContentsCardBaseProps>> contentsDataStream;
  late Stream<List<dynamic>> recentSearchesStream;

  Future<void> callApi([
    String? keyword,
    ContentType? type,
  ]) async {
    getPlanData(keyword, type);
    getContentsData(keyword, type);
  }

  Future<void> getPlanData([
    String? keyword,
    ContentType? type,
  ]) async {
    try {
      // Code below is just a simulation of api calls
      planDataController.sink.add(await getPseudoPlanData());
    } catch (error) {
      print(error);
      // error handle
    }
  }

  Future<void> getContentsData([
    String? keyword,
    ContentType? type,
  ]) async {
    try {
      UserInfoHandler model =
          Provider.of<UserInfoHandler>(context, listen: false);
      if (model.token != null) {
        contentsDataController.sink.add(await getContentsList(
          model.token!,
          keyword != null && keyword.length > 0 ? keyword : null,
          type,
        ));
      }
    } catch (error) {
      print("Error from getContentsData: $error");
      // error handle
    }
  }

  Future<void> searchOnSubmitted(String? keyword) async {
    if (keyword != null && keyword.length > 0) {
      await addSearchKeyword(keyword);
      setViewMode(BoardMainViewMode.result);
    }
  }

  Future<void> onResetButtonPressed() async {
    await resetSearchKeyword();
    loadSearchKeywords();
  }

  Future<void> initData() async => await callApi(searchInput);

  void handleModeChange(BoardMainViewMode _viewMode) {
    if (_viewMode == BoardMainViewMode.search) {
      loadSearchKeywords();
      print('onSearch');
      textEditingController.text = "";
    } else {
      callApi(searchInput, currentFilter);
    }
  }

  void addError(EventSink sink) => sink.addError("Unexpected Error");

  Future<void> _handlePlanData() async => await getPlanData(searchInput);

  Future<void> _handleContentsData() async =>
      await getContentsData(searchInput);

  Future<void> _handleSearchKeywords() async => await loadSearchKeywords();

  // Need Refactor
  Map<String, String> location = {"mainLocation": "국내", "subLocation": "전체"};

  /* =================================/================================= */
  /* =================CONSTRUCTORS & Widget METHODS================= */
  /* =================================/================================= */

  _BoardMainViewState() {
    planDataStream = planDataController.stream;
    contentsDataStream = contentsDataController.stream;
    recentSearchesStream = recentSearchController.stream;
  }

  @override
  void initState() {
    super.initState();
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

  AppBar buildAppBar(BuildContext context) {
    void onPressed() {
      switch (viewMode) {
        case BoardMainViewMode.main:
          Navigator.pop(context);
          break;
        case BoardMainViewMode.search:
          setSearchInput("");
          setViewMode(BoardMainViewMode.main);
          break;
        case BoardMainViewMode.result:
          setViewMode(BoardMainViewMode.search);
          break;
        default:
          break;
      }
    }

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      leading: buildLeading(
        context,
        viewMode: viewMode,
        onPressed: onPressed,
      ),
      title: buildTextField(
        textEditingController,
        viewMode: viewMode,
        onChanged: setSearchInput,
        onSubmitted: searchOnSubmitted,
        onTap: () => setViewMode(BoardMainViewMode.search),
      ),
      toolbarHeight: _toolbarHeight,
      actions: buildActions(setViewMode: setViewMode, viewMode: viewMode),
    );
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
        child: BoardMainViewStreamList<dynamic>(
            stream: recentSearchesStream,
            header: buildSearchBodyHeader(),
            emptyWidget: CenterNotice(text: '최근 검색기록이 없습니다'),
            errorWidget: CenterNotice(
              text: '예기치 못한 오류가 발생했습니다',
              actionText: "다시 시도",
              onActionPressed: _handleSearchKeywords,
            ),
            builder: (recentSearch) {
              if (recentSearch is String)
                return buildRecentSearchItem(
                    text: recentSearch,
                    onActionPressed: () => removeSearchKeyword(recentSearch),
                    onTap: () {
                      textEditingController.text = recentSearch;
                      setSearchInput(recentSearch);
                      searchOnSubmitted(recentSearch);
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
      viewMode: viewMode,
      tabIndex: tabIndex,
      onLeadingPressed: onLeadingPressed,
      onTabBarPressed: setTabIndex,
      onFilterBarPressed: (type) => setCurrentFilter(type),
    );
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
                Text(
                  "전체 삭제",
                  style: const TextStyle(
                      color: const Color(0xff555555),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 15.0),
                  textAlign: TextAlign.center,
                )
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
      stream: planDataStream,
      builder: (props) => ProductCard.fromProps(props: props),
      routeBuilder: (_, __) => PlanMakeView(),
      emptyWidget: CenterNotice(text: "불러올 수 있는 플랜이 없습니다"),
      errorWidget: CenterNotice(
        text: '예기치 못한 오류가 발생했습니다',
        actionText: "다시 시도",
        onActionPressed: () => getPlanData(searchInput, currentFilter),
      ),
    );
  }

  BoardMainViewStreamList buildContentListView(BuildContext context) {
    return BoardMainViewStreamList<ContentsCardBaseProps>(
      stream: contentsDataStream,
      builder: (props) => ContentsCard.fromProps(props: props),
      routeBuilder: (_, id) => ContentDetailView(
        id: id!,
      ),
      emptyWidget: CenterNotice(text: "불러올 수 있는 컨텐츠가 없습니다"),
      errorWidget: CenterNotice(
        text: '예기치 못한 오류가 발생했습니다',
        actionText: "다시 시도",
        onActionPressed: () => getContentsData(searchInput, currentFilter),
      ),
    );
  }
}
