import 'package:flutter/material.dart';
import 'package:prototype2021/views/board/base/board.dart';
import 'package:prototype2021/views/board/base/mixin/app_bar_text_button.dart';

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
  Future<void> initData() async => await callApi(searchInput);

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

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

  @override
  IconButton buildLeading() {
    Image leadingIcon = viewMode == BoardMode.search
        ? Image.asset('assets/icons/ic_arrow_left_back.png')
        : Image.asset("assets/icons/ic_remove_x.png");

    return IconButton(
      color: Colors.black,
      icon: leadingIcon,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  Widget buildTitle() {
    return buildTextField(
      textEditingController,
      viewMode: viewMode,
      onChanged: setSearchInput,
      onSubmitted: searchOnSubmitted,
      onTap: () => updateViewMode(BoardMode.search),
    );
  }

  @override
  Widget buildTextField(
    TextEditingController textController, {
    required BoardMode viewMode,
    void Function()? onTap,
    void Function(String?)? onSubmitted,
    void Function(String)? onChanged,
  }) {
    if (viewMode == BoardMode.main) {
      return SizedBox();
    }
    return super.buildTextField(
      textController,
      viewMode: viewMode,
      onTap: onTap,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
    );
  }

  @override
  List<Widget> buildActions() {
    List<Widget> actions = [
      TBAppBarTextButton(
          onPressed: () => setViewMode(BoardMode.search),
          icon: Image.asset("assets/icons/ic_main_search.png"),
          text: "검색"),
      TBAppBarTextButton(
          onPressed: () {},
          icon: Image.asset("assets/icons/ic_main_heart_default.png"),
          text: "찜목록"),
      TBAppBarTextButton(
          onPressed: () {},
          icon: Image.asset("assets/icons/ic_hamburger_menu.png"),
          text: "메뉴"),
    ];
    if (viewMode == BoardMode.search) actions = [];
    if (viewMode == BoardMode.result) actions.removeAt(0);
    return actions;
  }

  @override
  List<SliverAppBar> Function(BuildContext, bool) buildHeaderSilverBuilder() =>
      (BuildContext context, bool innerBoxIsScrolled) {
        if (viewMode == BoardMode.search) return [];
        List<SliverAppBar> slivers = <SliverAppBar>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: Colors.white,
            title: buildCurrentLocation(context,
                location: location, onLeadingPressed: onLeadingPressed),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            pinned: true,
            backgroundColor: Colors.white,
            title: buildTabBar(onTap: setTabIndex),
          ),
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
              )),
        ];
        // if (tabIndex == 1) slivers.removeAt(2);
        if (viewMode == BoardMode.result) slivers.removeAt(0);
        return slivers;
      };

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
  // BoardMainView에서는 뷰를 이동하면서 유지해야할 상태가 없기 때문에 구현하지 않고
  // [Navigator.push] 를 이용하였습니다
  Widget? buildContentsDetail(BuildContext context) => null;
}
