import 'package:flutter/material.dart';
import 'package:prototype2021/views/board/base/board.dart';
import 'package:prototype2021/views/board/base/mixin/stream_list.dart';
import 'package:prototype2021/views/board/plan/detail/plan_detail_view.dart';
import 'package:prototype2021/views/board/plan/make/plan_make_view.dart';
import 'package:prototype2021/widgets/cards/product_card.dart';
import 'package:prototype2021/widgets/notices/center_notice.dart';

class PlanSelectView extends StatefulWidget {
  final void Function(Navigate) navigator;
  const PlanSelectView({Key? key, required this.navigator}) : super(key: key);

  @override
  PlanSelectViewState createState() =>
      PlanSelectViewState(navigator: navigator);
}

class PlanSelectViewState extends BoardState<PlanSelectView> {
  /* =================================/================================= */
  /* =================CONSTRUCTORS & Widget METHODS================= */
  /* =================================/================================= */

  PlanSelectViewState({required this.navigator})
      : super.build(
          viewMode: BoardMode.main,
          initialTabIndex: 0,
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
  void setSelectedItemId(int planDetailId) => setState(() {
        selectedItemId = planDetailId;
      });

  bool loading = false;
  void setLoading(bool _loading) => setState(() {
        loading = _loading;
      });

  final void Function(Navigate) navigator;

  @override
  Future<void> initData() async =>
      await getPlanData(searchInput, currentFilter, true);

  @override
  void onBackButtonPressed() {
    switch (viewMode) {
      case BoardMode.main:
        Navigator.pop(context);
        break;
      case BoardMode.search:
        setSearchInput("");
        setViewMode(BoardMode.main);
        break;
      case BoardMode.result:
        setViewMode(BoardMode.search);
        break;
      case BoardMode.planDetail:
        if (prevViewMode == BoardMode.result) {
          setViewMode(BoardMode.result);
        } else {
          setViewMode(BoardMode.main);
        }
        break;
      default:
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
      case BoardMode.planDetail:
        return Text("플랜 정보",
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
        if (viewMode == BoardMode.search || viewMode == BoardMode.planDetail)
          return [];
        // WidgetsBinding.instance?.addPostFrameCallback((_) async {
        //   await _countContents();
        // });
        List<SliverAppBar> slivers = <SliverAppBar>[
          // SliverAppBar(
          //     automaticallyImplyLeading: false,
          //     shadowColor: Color(0x29000000),
          //     forceElevated: true,
          //     elevation: 3,
          //     pinned: true,
          //     backgroundColor: Colors.white,
          //     title: buildThemeBar(
          //       onFilterChange: (type) => setCurrentFilter(type),
          //       currentFilter: currentFilter,
          //       isEnabled: tabIndex == 1,
          //     )),
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
  BoardStreamList buildPlanListView(BuildContext context) {
    return BoardStreamList<ProductCardBaseProps>(
      stream: planDataStream,
      builder: (props) => ProductCard.fromProps(
        props: props,
        footer: buildAddToCompanionButton(props.id),
      ),
      onTap: (props) {
        setSelectedItemId(props.id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlanDetailView(pid: props.id)));
        setViewMode(BoardMode.planDetail);
      },
      emptyWidget: CenterNotice(text: "불러올 수 있는 플랜이 없습니다"),
      errorWidget: CenterNotice(
        text: '예기치 못한 오류가 발생했습니다',
        actionText: "다시 시도",
        onActionPressed: () => getPlanData(searchInput, currentFilter, true),
      ),
    );
  }

  @override
  Widget buildContentListView(BuildContext context) => SizedBox();

  TextButton buildAddToCompanionButton(int id) {
    void onPressed() async {
      Navigator.pop(context, {"id": id});
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
              loading ? "담는 중..." : "이 플랜으로 동행 찾기",
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
  Widget? buildContentsDetail(BuildContext context) {
    return SizedBox();
  }
}
