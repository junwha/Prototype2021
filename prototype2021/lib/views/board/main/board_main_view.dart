import 'package:flutter/material.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/views/board/base/board.dart';
import 'package:prototype2021/views/board/base/mixin/stream_list.dart';
import 'package:prototype2021/views/board/content/detail/content_detail_view.dart';
import 'package:prototype2021/views/board/plan/make/plan_make_view.dart';
import 'package:prototype2021/widgets/cards/contents_card.dart';
import 'package:prototype2021/widgets/cards/product_card.dart';
import 'package:prototype2021/widgets/notices/center_notice.dart';
import 'package:provider/provider.dart';

class BoardMainView extends StatefulWidget {
  const BoardMainView({Key? key}) : super(key: key);

  @override
  _BoardMainViewState createState() => _BoardMainViewState();
}

class _BoardMainViewState extends BoardState<BoardMainView> {
  /* =================================/================================= */
  /* =================CONSTRUCTORS & Widget METHODS================= */
  /* =================================/================================= */

  _BoardMainViewState() : super.build(viewMode: BoardMode.main);

  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

  @override
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

  @override
  Future<void> getContentsData([
    String? keyword,
    ContentType? type,
  ]) async {
    try {
      UserInfoHandler model =
          Provider.of<UserInfoHandler>(context, listen: false);
      if (model.token != null) {
        contentsDataController.sink.add(await contentsLoader.getContentsList(
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
      default:
        break;
    }
  }

  @override
  List<SliverAppBar> processHeaderItems({
    required List<SliverAppBar> defaultSlivers,
    required BoardMode mode,
    required int tabIndex,
  }) {
    // if (tabIndex == 1) defaultSlivers.removeAt(2);
    if (mode == BoardMode.search) defaultSlivers = [];
    if (mode == BoardMode.result) defaultSlivers.removeAt(0);
    return defaultSlivers;
  }

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
  Container? buildBottomNavigationBar() {
    if (viewMode == BoardMode.search) {
      return Container(
        child: buildResetSearchesButton(onPressed: onResetButtonPressed),
      );
    } else {
      return null;
    }
  }

  @override
  BoardStreamList buildPlanListView(BuildContext context) {
    return BoardStreamList<ProductCardBaseProps>(
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

  @override
  BoardStreamList buildContentListView(BuildContext context) {
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
        onActionPressed: () => getContentsData(searchInput, currentFilter),
      ),
    );
  }

  @override
  // BoardMainView에서는 뷰를 이동하면서 유지해야할 상태가 없기 때문에 구현하지 않고
  // [Navigator.push] 를 이용하였습니다
  Widget? buildContentsDetail(BuildContext context) => null;
}
