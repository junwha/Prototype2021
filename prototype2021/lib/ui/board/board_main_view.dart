import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/board/app_bar_text_button.dart';
import 'package:prototype2021/theme/board/board_list_view.dart';
import 'package:prototype2021/theme/board/helpers.dart';
import 'package:prototype2021/theme/cards/contents_card.dart';
import 'package:prototype2021/theme/cards/contents_card_base.dart';
import 'package:prototype2021/theme/cards/product_card.dart';
import 'package:prototype2021/theme/cards/product_card_base.dart';
import 'package:prototype2021/theme/pop_up.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';
import 'package:prototype2021/ui/board/content_detail_view.dart';
import 'package:prototype2021/ui/board/plan_make_view.dart';
import 'package:prototype2021/ui/board/select_location_toggle_view.dart';
import 'package:prototype2021/ui/event/filter_view.dart';

class BoardMainView extends StatefulWidget {
  const BoardMainView({Key? key}) : super(key: key);

  @override
  _BoardMainViewState createState() => _BoardMainViewState();
}

class _BoardMainViewState extends State<BoardMainView>
    with BoardMainViewHelpers {
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
          headerSliverBuilder: buildHeaderSilverBuilder(),
          body: TabBarView(children: [
            buildPlanListView(context),
            buildContentListView(context),
          ]),
        ),
      ),
    );
  }

  BoardListView buildPlanListView(BuildContext context) {
    return BoardListView<ProductCardBaseProps>(
      data: generatePseudoPlanData(setState, heartSelected),
      builder: (props) => ProductCard(props: props),
      routeBuilder: (_) => PlanMakeView(),
    );
  }

  BoardListView buildContentListView(BuildContext context) {
    return BoardListView<ContentsCardBaseProps>(
      data: generatePseudoContentData(setState, heartSelected),
      builder: (props) => ContentsCard(props: props),
      routeBuilder: (_) => ContentDetailView(),
    );
  }

  List<SliverAppBar> Function(BuildContext, bool) buildHeaderSilverBuilder() =>
      (BuildContext context, bool innerBoxIsScrolled) {
        return <SliverAppBar>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: Colors.white,
            title: buildCurrentLocation(),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            pinned: true,
            backgroundColor: Colors.white,
            title: buildTabBar(),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            shadowColor: Color(0x29000000),
            forceElevated: true,
            pinned: true,
            backgroundColor: Colors.white,
            title: buildFilterBar(),
          )
        ];
      };

  SingleChildScrollView buildFilterBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SelectableTextButton(
            isChecked: true,
            titleName: "모두보기",
            onPressed: () {},
          ),
          SizedBox(width: 8 * pt),
          SelectableTextButton(
            isChecked: false,
            titleName: "여행지",
            onPressed: () {},
          ),
          SizedBox(width: 8 * pt),
          SelectableTextButton(
            isChecked: false,
            titleName: "카페",
            onPressed: () {},
          ),
          SizedBox(width: 8 * pt),
          SelectableTextButton(
            isChecked: false,
            titleName: "음식점",
            onPressed: () {},
          ),
          SizedBox(width: 8 * pt),
          SelectableTextButton(
            isChecked: false,
            titleName: "숙소",
            onPressed: () {},
          ),
          SizedBox(width: 8 * pt),
          SelectableTextButton(
            isChecked: false,
            titleName: "기타",
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget buildTabBar() {
    return TabBar(
      unselectedLabelColor: Color(0xffbdbdbd),
      labelColor: Colors.black,
      indicatorColor: Colors.black,
      indicatorWeight: 1 * pt,
      tabs: [
        Tab(
          child: Container(
            child: Text(
              '플랜',
              style: TextStyle(
                fontSize: 15 * pt,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Tab(
          child: Text(
            '컨텐츠',
            style: TextStyle(
              fontSize: 15 * pt,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
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

  Widget buildCurrentLocation() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10 * pt, 12 * pt, 15 * pt, 29 * pt),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Row(
                children: [
                  Text(
                    '${location["mainLocation"]} ${location["subLocation"]}',
                    style: TextStyle(
                      color: Color(0xff444444),
                      fontFamily: 'Roboto',
                      fontSize: 23 * pt,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 10 * pt),
                  ImageIcon(
                    AssetImage("assets/icons/ic_area_arrow_down_unfold.png"),
                    color: Colors.black,
                    size: 14 * pt,
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (context) => SelectLocationToggleView(
                              mainLocation: location["mainLocation"] ?? "",
                              subLocation: location["subLocation"] ?? "",
                            ))).then((value) {
                  setState(() {
                    Map<String, String> _location =
                        value as Map<String, String>;
                    if (_location.containsKey("mainLocation") &&
                        _location.containsKey("subLocation")) {
                      location = _location;
                    }
                  });
                });
              },
            ),
            IconButton(
              onPressed: () {
                tbShowDialog(
                    context,
                    TBLargeDialog(
                      title: "",
                      insetsPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                      padding: EdgeInsets.all(20),
                      body: SingleChildScrollView(child: FilterView()),
                    ));
              },
              icon: Image.asset("assets/icons/ic_filter_gray.png"),
            ),
          ],
        ),
      ),
    );
  }
}
