import 'package:flutter/material.dart';
import 'package:prototype2021/handler/board/plan/plan_make_calendar_handler.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/model/board/contents/content_detail.dart';
import 'package:prototype2021/model/board/place_data_props.dart';
import 'package:prototype2021/utils/logger/logger.dart';
import 'package:prototype2021/views/board/base/board.dart';
import 'package:prototype2021/views/board/base/mixin/stream_list.dart';
import 'package:prototype2021/views/board/content/detail/content_detail_view.dart';
import 'package:prototype2021/views/board/plan/make/plan_make_view.dart';
import 'package:prototype2021/widgets/cards/contents_card.dart';
import 'package:prototype2021/widgets/notices/center_notice.dart';
import 'package:provider/provider.dart';

class PlanMakeSelectView extends StatefulWidget {
  final void Function(Navigate) navigator;
  const PlanMakeSelectView({Key? key, required this.navigator})
      : super(key: key);

  @override
  PlanMakeSelectViewState createState() =>
      PlanMakeSelectViewState(navigator: navigator);
}

class PlanMakeSelectViewState extends BoardState<PlanMakeSelectView> {
  /* =================================/================================= */
  /* =================CONSTRUCTORS & Widget METHODS================= */
  /* =================================/================================= */

  PlanMakeSelectViewState({required this.navigator})
      : super.build(
          viewMode: BoardMode.main,
          initialTabIndex: 1,
        );

  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

  BoardMode? prevViewMode;

  @override
  void setViewMode(BoardMode _viewMode) => setState(() {
        prevViewMode = viewMode;
        super.setViewMode(_viewMode);
      });

  int? selectedItemId;
  void setSelectedItemId(int contentsDetailId) => setState(() {
        selectedItemId = contentsDetailId;
      });

  bool loading = false;
  void setLoading(bool _loading) => setState(() {
        loading = _loading;
      });

  final void Function(Navigate) navigator;

  @override
  Future<void> initData() async =>
      await getContentsData(searchInput, currentFilter, true);

  @override
  void onBackButtonPressed() {
    switch (viewMode) {
      case BoardMode.main:
        navigator(Navigate.backward);
        break;
      case BoardMode.search:
        setSearchInput("");
        setViewMode(BoardMode.main);
        break;
      case BoardMode.result:
        setViewMode(BoardMode.search);
        break;
      case BoardMode.contentsDetail:
        if (prevViewMode == BoardMode.result) {
          setViewMode(BoardMode.result);
        } else {
          setViewMode(BoardMode.main);
        }
        break;
    }
  }

  // TODO: 아이템 갯수 상태관리 구현
  // int? _contentsNumber;
  // void _setContentsNumber(int? countedContents) => setState(() {
  //       _contentsNumber = countedContents;
  //     });

  // Future<void> _countContents() async {
  //   _setContentsNumber(await contentsDataStream.length);
  // }

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

  @override
  Widget buildBody(BuildContext context) {
    switch (viewMode) {
      case BoardMode.search:
        return buildSearchBody();
      case BoardMode.contentsDetail:
        return buildContentsDetail(context);
      default:
        return buildDefaultBody(context);
    }
  }

  @override
  AppBar? buildAppBar(BuildContext context) {
    if (viewMode == BoardMode.contentsDetail) {
      return null;
    }
    return super.buildAppBar(context);
  }

  @override
  List<Widget> buildActions() => [];

  @override
  Widget buildTitle() {
    switch (viewMode) {
      case BoardMode.contentsDetail:
        return Text("컨텐츠 정보",
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 15.0),
            textAlign: TextAlign.left);
      default:
        return buildTextField(
          textEditingController,
          viewMode: viewMode,
          onChanged: setSearchInput,
          onSubmitted: searchOnSubmitted,
          onTap: () => updateViewMode(BoardMode.search),
        );
    }
  }

  @override
  IconButton buildLeading() {
    return IconButton(
      onPressed: onBackButtonPressed,
      icon: Image.asset('assets/icons/ic_arrow_left_back.png'),
    );
  }

  @override
  List<SliverAppBar> Function(BuildContext, bool) buildHeaderSilverBuilder() =>
      (BuildContext context, bool innerBoxIsScrolled) {
        if (viewMode == BoardMode.search ||
            viewMode == BoardMode.contentsDetail) return [];
        // WidgetsBinding.instance?.addPostFrameCallback((_) async {
        //   await _countContents();
        // });
        List<SliverAppBar> slivers = <SliverAppBar>[
          SliverAppBar(
              automaticallyImplyLeading: false,
              shadowColor: Color(0x29000000),
              forceElevated: true,
              elevation: 3,
              pinned: true,
              backgroundColor: Colors.white,
              title: buildThemeBar(
                onFilterChange: (type) => setCurrentFilter(type),
                currentFilter: currentFilter,
                isEnabled: tabIndex == 1,
              )),
          // TODO: ListView Header 구현 (아이템 갯수 등)
          // SliverAppBar(
          //   automaticallyImplyLeading: false,
          //   elevation: 0,
          //   pinned: false,
          //   backgroundColor: Colors.white,
          //   title: buildListHeader(
          //       titleText: _contentsNumber == null
          //           ? "로딩중..."
          //           : "전체 ${_contentsNumber.toString()}"),
          // )
        ];
        return slivers;
      };

  @override
  Widget? buildBottomNavigationBar() => null;

  @override
  Widget buildPlanListView(BuildContext context) => SizedBox();

  @override
  BoardStreamList buildContentListView(BuildContext context) {
    return BoardStreamList<ContentsCardBaseProps>(
      stream: contentsDataStream,
      builder: (props) => ContentsCard.fromProps(
        props: props,
        footer: buildAddToPlanButton(props.id),
      ),
      onTap: (props) {
        setSelectedItemId(props.id);
        setViewMode(BoardMode.contentsDetail);
      },
      emptyWidget: CenterNotice(text: "불러올 수 있는 컨텐츠가 없습니다"),
      errorWidget: CenterNotice(
        text: '예기치 못한 오류가 발생했습니다',
        actionText: "다시 시도",
        onActionPressed: () =>
            getContentsData(searchInput, currentFilter, true),
      ),
    );
  }

  TextButton buildAddToPlanButton(int id) {
    UserInfoHandler userInfoHandler =
        Provider.of<UserInfoHandler>(context, listen: false);
    PlanMakeHandler calendarHandler = Provider.of<PlanMakeHandler>(context);
    void onPressed() async {
      try {
        setLoading(true);
        ContentsDetail result = await contentsLoader.getContentDetail(
            id, userInfoHandler.token ?? "");
        calendarHandler.addPlaceData(
          calendarHandler.currentIndex,
          PlaceDataProps.fromContentsDetail(source: result),
        );
        setLoading(false);
        navigator(Navigate.backward);
      } catch (error) {
        Logger.errorWithInfo(
            error, "plan_make_select_view.dart -> buildAddToPlanButton");
        setLoading(false);
      }
    }

    return TextButton(
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 28,
            ),
            SizedBox(width: 6),
            Text(
              loading ? "담는 중..." : "플랜에 담기",
              style: const TextStyle(
                  color: const Color(0xff555555),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0),
              textAlign: TextAlign.left,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        // decoration: BoxDecoration(
        //     border: Border.all(
        //   width: 0.5,
        //   color: const Color(0xffe8e8e8),
        // )),
      ),
    );
  }

  @override
  Widget buildContentsDetail(BuildContext context) {
    if (selectedItemId == null) {
      return SizedBox();
    }
    return ContentDetailView(
      id: selectedItemId!,
      mode: ContentsDetailMode.planMake,
    );
  }
}
