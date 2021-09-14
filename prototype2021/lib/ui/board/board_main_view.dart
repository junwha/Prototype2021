import 'package:flutter/material.dart';
import 'package:prototype2021/theme/board/app_bar_text_button.dart';
import 'package:prototype2021/theme/board/board_list_view.dart';
import 'package:prototype2021/theme/board/header_silver.dart';
import 'package:prototype2021/theme/board/helpers.dart';
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

class _BoardMainViewState extends State<BoardMainView>
    with BoardMainHeaderSilverMixin, BoardMainViewHelpers {
  Map<String, String> location = {"mainLocation": "국내", "subLocation": "전체"};
  bool heartSelected = false;
  bool heartSelected2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: buildHeaderBuilder(context),
          body: TabBarView(children: [
            buildPlanListView(context),
            buildContentListView(context),
          ]),
        ),
      ),
    );
  }

  List<SliverAppBar> Function(BuildContext, bool) buildHeaderBuilder(
      BuildContext context) {
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
        location: location, onLeadingPressed: onLeadingPressed);
  }

  /* 
   * This(buildPlanListView and buildContentListView) is temporary implementation. 
   * isHeartSelected state should be handled  
   * at the individual ProductCard or ContentsCard level, 
   * not at the root widget level(BoardMainView)
   */
  BoardListView buildPlanListView(BuildContext context) {
    return BoardListView<ProductCardBaseProps>(
      data: generatePseudoPlanData((bool isSelected) {
        setState(() {
          heartSelected = isSelected;
        });
      }, heartSelected),
      builder: (props) => ProductCard(props: props),
      routeBuilder: (_) => PlanMakeView(),
    );
  }

  BoardListView buildContentListView(BuildContext context) {
    return BoardListView<ContentsCardBaseProps>(
      data: generatePseudoContentData((bool isSelected) {
        setState(() {
          heartSelected2 = isSelected;
        });
      }, heartSelected2),
      builder: (props) => ContentsCard(props: props),
      routeBuilder: (_) => ContentDetailView(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      leading: IconButton(
        color: Colors.black,
        icon: Image.asset("assets/icons/ic_remove_x.png"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      toolbarHeight: 60,
      actions: [
        AppBarTextButton(
            onPressed: () {},
            icon: Image.asset("assets/icons/ic_main_search.png"),
            text: "검색"),
        AppBarTextButton(
            onPressed: () {},
            icon: Image.asset("assets/icons/ic_main_heart_default.png"),
            text: "찜목록"),
        AppBarTextButton(
            onPressed: () {},
            icon: Image.asset("assets/icons/ic_hamburger_menu.png"),
            text: "메뉴"),
      ],
    );
  }
}
