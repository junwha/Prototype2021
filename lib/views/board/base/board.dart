import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prototype2021/data/location_data.dart';
import 'package:prototype2021/loader/board/plan_loader.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/loader/board/contents_loader.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/settings/annotations.dart';
import 'package:prototype2021/views/board/base/mixin/app_bar.dart';
import 'package:prototype2021/views/board/base/mixin/header_silver.dart';
import 'package:prototype2021/views/board/base/mixin/helpers.dart';
import 'package:prototype2021/views/board/base/mixin/search_logic.dart';
import 'package:prototype2021/views/board/base/mixin/search_widget.dart';
import 'package:prototype2021/views/board/base/mixin/stream_list.dart';
import 'package:prototype2021/views/board/base/location/select_location_toggle_view.dart';
import 'package:prototype2021/views/board/content/detail/content_detail_view.dart';
import 'package:prototype2021/views/board/plan/detail/plan_detail_view.dart';
import 'package:prototype2021/views/board/plan/make/plan_make_view.dart';
import 'package:prototype2021/widgets/cards/contents_card.dart';
import 'package:prototype2021/widgets/cards/product_card.dart';
import 'package:prototype2021/widgets/notices/center_notice.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

const double _toolbarHeight = 60;

enum BoardRenderMode {
  /// Default 모드입니다
  /// Board 위젯의 모든 서브위젯과 로직을 사용합니다
  main,

  /// Wishlist 모드입니다
  /// 플랜과 컨텐트의 위시리스트를 보여줍니다
  wishlist,

  /// Search 모드입니다
  /// [BoardMode.main]에만 엑세스할 수 없습니다
  search,
}

enum BoardMode {
  /// Default 화면을 의미합니다
  main,

  /// 검색 화면을 의미합니다
  search,

  /// 검색 결과창을 의미합니다
  result,

  /// 컨텐츠 디테일 페이지를 의미합니다.
  ///
  /// 이 모드를 둔 이유는
  /// 이 페이지를 [Navigator.push]로 라우팅 하지 않고 모드를 바꿔서 들어가게 해서
  /// PlanMakeView에서 Provider의 컨텍스트 안에 계속 있게 하여
  /// 상태을 잃지 않게 해야하는 위젯들이 있기 때문입니다.
  contentsDetail,
}

abstract class BoardState<T extends StatefulWidget> extends State<T>
    with
        BoardMainSilverMixin,
        BoardAppBarMixin,
        BoardSearchWidgetMixin,
        BoardSearchLogicMixin,
        BoardHelpers {
  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

  int refetchCount = 0;
  final int maxRefetchCount = 3;
  void setRefetchCount(int _refetchCount) => setState(() {
        refetchCount = _refetchCount;
      });

  BoardMode viewMode;
  @defaultImplementation
  void setViewMode(BoardMode _viewMode) => setState(() {
        viewMode = _viewMode;
        refetchCount = 0;
      });
  Future<void> updateViewMode(BoardMode _viewMode) async {
    setViewMode(_viewMode);
    handleModeChange(_viewMode);
  }

  String searchInput = "";
  void setSearchInput(String _searchInput) => setState(() {
        searchInput = _searchInput;
      });

  final int initialTabIndex;
  int tabIndex = 0;
  void setTabIndex(int _tabIndex) => setState(() {
        tabIndex = _tabIndex;
      });

  ContentType currentFilter = ContentType.unknown;
  void setCurrentFilter(ContentType newFilter) {
    setState(() {
      currentFilter = newFilter;
    });
    callApi(searchInput, newFilter, true);
  }

  // The types inside Lists are temporary implementation.
  // If needed, this types can be changed.
  StreamController<List<ProductCardBaseProps>> planDataController =
      new BehaviorSubject<List<ProductCardBaseProps>>();
  StreamController<List<ContentsCardBaseProps>> contentsDataController =
      new BehaviorSubject<List<ContentsCardBaseProps>>();

  late Stream<List<ProductCardBaseProps>> planDataStream;
  late Stream<List<ContentsCardBaseProps>> contentsDataStream;
  late Stream<List<dynamic>> recentSearchesStream;

  @defaultImplementation
  PlanLoader planLoader = new PlanLoader.withMode(mode: PlanLoaderMode.board);
  ContentsLoader contentsLoader = new ContentsLoader();

  Future<void> callApi([
    String? keyword,
    ContentType? type,
    bool reset = false,
  ]) async {
    getPlanData(keyword, type, reset);
    getContentsData(keyword, type, reset);
  }

  @defaultImplementation
  Future<void> getPlanData([
    String? keyword,
    ContentType? type,
    bool reset = false,
  ]) async {
    try {
      UserInfoHandler model =
          Provider.of<UserInfoHandler>(context, listen: false);
      if (model.token != null) {
        planDataController.sink.add(await planLoader.getPlanList(model.token!));
      }
    } catch (error) {
      print(error);
      // error handle
    }
  }

  @defaultImplementation
  Future<void> getContentsData([
    String? keyword,
    ContentType? type,
    bool reset = false,
  ]) async {
    try {
      UserInfoHandler model =
          Provider.of<UserInfoHandler>(context, listen: false);
      int? areaCode = areaCodeToAreaName.keys.firstWhere(
          (k) => areaCodeToAreaName[k] == location['mainLocation'],
          orElse: () => -1);
      int? areaDetailCode;
      if (areaCode == -1)
        areaCode = null;
      else {
        areaDetailCode = areaCodeToDetailName[areaCode]?.keys.firstWhere((k) =>
            areaCodeToDetailName[areaCode]?[k] == location['subLocation']);
      }
      if (model.token != null) {
        contentsDataController.sink.add(await contentsLoader.getContentsList(
          token: model.token!,
          keyword: keyword != null && keyword.length > 0 ? keyword : null,
          type: type,
          reset: reset,
          areaCode: areaCode,
          areaDetailCode: areaDetailCode,
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
      updateViewMode(BoardMode.result);
    }
  }

  Future<void> onResetButtonPressed() async {
    await resetSearchKeyword();
    loadSearchKeywords();
  }

  @defaultImplementation
  Future<void> initData() async => await callApi(searchInput);

  void handleModeChange(BoardMode _viewMode) {
    if (_viewMode == BoardMode.search) {
      loadSearchKeywords();
      print('onSearch');
      textEditingController.text = "";
    } else {
      callApi(searchInput, currentFilter, true);
    }
  }

  void addError(EventSink sink) => sink.addError("Unexpected Error");

  Future<void> _handleSearchKeywords() async => await loadSearchKeywords();

  void _mapControllerToStream() {
    planDataStream = planDataController.stream;
    contentsDataStream = contentsDataController.stream;
    recentSearchesStream = recentSearchController.stream;
  }

  Map<String, String> location = {"mainLocation": "국내", "subLocation": "전체"};

  /* =================================/================================= */
  /* ===================CONSTRUCTORS & Widget METHODS=================== */
  /* =================================/================================= */

  BoardState()
      : viewMode = BoardMode.main,
        initialTabIndex = 0 {
    _mapControllerToStream();
  }

  BoardState.build({required this.viewMode, this.initialTabIndex = 0}) {
    _mapControllerToStream();
  }

  @override
  void initState() {
    super.initState();
    setTabIndex(initialTabIndex);
    initData();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    recentSearchController.close();
    planDataController.close();
    contentsDataController.close();
    super.dispose();
  }

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: DefaultTabController(
        initialIndex: initialTabIndex,
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: buildHeaderSilverBuilder(),
          body: buildBody(context),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  @defaultImplementation
  Widget buildBody(BuildContext context) {
    switch (viewMode) {
      case BoardMode.search:
        return buildSearchBody();
      default:
        return buildDefaultBody(context);
    }
  }

  @needsImplement
  void onBackButtonPressed();

  @needsImplement
  Widget buildTitle();

  @defaultImplementation
  AppBar? buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      leading: buildLeading(),
      title: buildTitle(),
      toolbarHeight: _toolbarHeight,
      actions: buildActions(),
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
        child: BoardStreamList<dynamic>(
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

  @needsImplement
  Widget? buildBottomNavigationBar();

  @defaultImplementation
  Widget buildPlanListView(BuildContext context) {
    return BoardStreamList<ProductCardBaseProps>(
      stream: planDataStream,
      builder: (props) => ProductCard.fromProps(props: props),
      routeBuilder: (_, id) => PlanDetailView(pid: id!),
      emptyWidget: CenterNotice(text: "불러올 수 있는 플랜이 없습니다"),
      errorWidget: CenterNotice(
        text: '예기치 못한 오류가 발생했습니다',
        actionText: "다시 시도",
        onActionPressed: () => getPlanData(searchInput, currentFilter, true),
      ),
    );
  }

  @defaultImplementation
  Widget buildContentListView(BuildContext context) {
    return BoardStreamList<ContentsCardBaseProps>(
      stream: contentsDataStream,
      builder: (props) => ContentsCard.fromProps(props: props),
      routeBuilder: (_, id) => ContentDetailView(
        id: id!,
      ),
      emptyWidget: CenterNotice(text: "불러올 수 있는 컨텐츠가 없습니다"),
      errorWidget: CenterNotice(
        text: '예기치 못한 오류가 발생했습니다',
        actionText: "다시 시도",
        onActionPressed: () =>
            getContentsData(searchInput, currentFilter, true),
      ),
    );
  }

  @needsImplement
  Widget? buildContentsDetail(BuildContext context);
}
