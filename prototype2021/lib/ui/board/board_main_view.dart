import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/cards/card.dart';
import 'package:prototype2021/theme/pop_up.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';
import 'package:prototype2021/ui/board/content_detail_view.dart';
import 'package:prototype2021/ui/board/select_location_toggle_view.dart';
import 'package:prototype2021/ui/event/filter_view.dart';
import 'package:prototype2021/ui/event/my_page_view.dart';

class BoardMainView extends StatefulWidget {
  const BoardMainView({Key? key}) : super(key: key);

  @override
  _BoardMainViewState createState() => _BoardMainViewState();
}

class _BoardMainViewState extends State<BoardMainView> {
  bool heartSelected = false;
  bool heartSelected2 = false;
  Map<String, String> location = {"mainLocation": "국내", "subLocation": "전체"};

  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = <String>['Plan', 'Content'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
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
          },
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Column(
                  children: List.generate(
                20,
                (index) => ProductCard(
                  preview: placeHolder,
                  title: "중국 도장깨기",
                  place: '상하이(중국), 베이징(중국), 광저우(중국)',
                  period: 3,
                  costStart: 3,
                  costEnd: 5,
                  matchPercent: 34,
                  tags: ["액티비티", "관광명소", "인생사진"],
                  tendencies: [],
                  onHeartPreessed: (bool isSelected) {
                    setState(() {
                      this.heartSelected2 = !isSelected;
                    });
                    print(heartSelected2);
                  },
                  isHeartSelected: this.heartSelected2,
                  isGuide: index % 2 == 0,
                ),
              )),
            ),
            SingleChildScrollView(
              child: Column(
                children: List.generate(
                  20,
                  (index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContentDetailView()));
                    },
                    child: ContentsCard(
                      preview: placeHolder,
                      title: "울산대공원",
                      place: "대한민국, 울산",
                      explanation: "다양한 놀이 기구와 운동 시설을 갖춘 도심 공원, 울산대공원'",
                      rating: 5,
                      ratingNumbers: 34,
                      tags: ["액티비티", "관광명소", "인생사진"],
                      isHeartSelected: heartSelected,
                      onHeartPreessed: (bool isSelected) {
                        setState(() {
                          this.heartSelected = !isSelected;
                        });
                        print(heartSelected);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

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

  AppBar buildAppBar() {
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

class AppBarTextButton extends StatelessWidget {
  Function() onPressed;
  Image icon;
  String text;

  AppBarTextButton({
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: this.onPressed,
      icon: Column(
        children: [
          this.icon,
          Text(
            this.text,
            style: TextStyle(
              color: Color(0xff555555),
              fontSize: 10,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}
