import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:prototype2021/model/signin/http/signup.dart';
import 'package:prototype2021/handler/event/event_article_handler.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/widgets/cards/timer_card.dart';
import 'package:prototype2021/views/event/main/mixin/event_articles.dart';
import 'package:prototype2021/views/event/main/mixin/event_filter.dart';
import 'package:prototype2021/widgets/dialogs/pop_up.dart';
import 'package:prototype2021/widgets/buttons/selectable_text_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:prototype2021/widgets/buttons/tb_event_more_button.dart';
import 'package:prototype2021/views/board/main/location/select_location_toggle_view.dart';
import 'package:prototype2021/views/event/editor/editor_view.dart';
import 'package:prototype2021/views/event/detail/event_detail_view.dart';
import 'package:prototype2021/views/event/search/event_search_view.dart';
import 'package:prototype2021/views/mypage/my_page_view.dart';
import 'package:provider/provider.dart';
import 'package:prototype2021/widgets/notices/top_notice.dart';

class EventMainView extends StatefulWidget {
  @override
  _EventMainViewState createState() => _EventMainViewState();
}

class _EventMainViewState extends State<EventMainView>
    with EventFilter<EventMainView> {
  // ------------------------------------------------------------------------------------- //
  // -------------------------------------- State -------------------------------------- //
  // ------------------------------------------------------------------------------------- //
  List<String> images = [
    'https://t3.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/2fG8/image/InuHfwbrkTv4FQQiaM7NUvrbi8k.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Hong_Kong_Night_view.jpg/450px-Hong_Kong_Night_view.jpg'
  ];
  int _pageIndex = 0;
  double imageIndex = 0;
  bool isAllList = false;

  // Event/Companion Filters
  Map<String, String> location = {"mainLocation": "국내", "subLocation": "전체"};
  Map<Gender, bool> isGenderSelected = {
    Gender.M: true,
    Gender.F: true,
    Gender.None: true
  };
  RangeValues ageRange = RangeValues(0, 100);
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(days: 7)));

  // ------------------------------------------------------------------------------------- //
  // -------------------------------------- Widgets -------------------------------------- //
  // ------------------------------------------------------------------------------------- //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      // bottomNavigationBar: buildBottomNavigationBar(),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => EventArticleHandler.main(),
          child: Consumer(
            builder: (context, EventArticleHandler eventArticleModel, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TopNoticeSlider(),
                  buildCurrentLocation(),
                  buildSelectSection(
                      eventArticleModel), // 현재 위치, 지도보기 / 내 주변 이벤트, 동행 찾기
                  buildImageArea(),
                  SizedBox(
                    height: 30,
                  ),
                  buildArticleList(eventArticleModel),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildArticleList(EventArticleHandler eventArticleModel) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "마감 임박 게시글",
                  style: TextStyle(
                      color: Color(0xff555555),
                      fontWeight: FontWeight.bold,
                      fontSize: 14 * pt),
                ),
              ],
            ),
          ),
        ),
        buildEventArticles(eventArticleModel),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          child: !isAllList ? SizedBox() : EventArticles(eventArticleModel),
        ),
        TBEventMoreButton(isAllList: isAllList)
      ],
    );
  }

  Widget buildEventArticles(EventArticleHandler eventArticleModel) {
    if (eventArticleModel.isTopEventArticleLoading) return Text("Loading ...");
    return Column(
      children: eventArticleModel.topEventArticleList
          .map(
            (e) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                    return EventDetailView(
                        e.id, eventArticleModel, eventArticleModel.articleType);
                  }),
                );
              },
              child: TimerCard(
                title: e.title,
                description: e.summary,
                due: e.period.end,
                onEnd: () {
                  eventArticleModel.loadTopArticles();
                },
              ),
            ),
          )
          .toList(),
    );
  }

  Stack buildImageArea() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (i, reason) {
                setState(() {
                  imageIndex = i.toDouble();
                });
              },
              height: 200,
              viewportFraction: 1,
            ),
            items: images.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/icons/image_bar.png",
                      fit: BoxFit.cover,
                      scale: 20,
                    ),
                  );
                },
              );
            }).toList()),
        DotsIndicator(
          dotsCount: images.length,
          position: imageIndex,
        )
      ],
    );
  }

  Padding buildSelectSection(EventArticleHandler articleModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15 * pt, 12 * pt, 15 * pt, 30 * pt),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TBSelectableTextButton(
                  titleName: "내 주변 이벤트",
                  isChecked: articleModel.articleType == ArticleType.EVENT,
                  onPressed: () {
                    setState(() {
                      articleModel.setArticleType(ArticleType.EVENT);
                    });
                  }),
              SizedBox(width: 10),
              TBSelectableTextButton(
                  titleName: "동행찾기",
                  isChecked: articleModel.articleType == ArticleType.COMPANION,
                  onPressed: () {
                    setState(() {
                      articleModel.setArticleType(ArticleType.COMPANION);
                    });
                  }),
            ],
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // buildFilterButton(), TODO: 필터 구현후 enable
            IconButton(
              icon: Image.asset(
                "assets/icons/editor.png",
                width: 40,
                height: 40,
              ),
              onPressed: () async {
                try {
                  bool result = await Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return EditorView();
                  })) as bool;
                  if (result) {
                    articleModel.loadTopArticles();
                    articleModel.loadArticles();
                  }
                } catch (e) {}
              },
            )
          ]),
        ],
      ),
    );
  }

  /// 이벤트 / 동행찾기의 필터 뷰를 구성하는 버튼
  /// Filter 관련 State를 mixin에 주입하여 사용
  IconButton buildFilterButton() {
    return IconButton(
      onPressed: () {
        tbShowDialog(context, StatefulBuilder(builder: (context, setState) {
          return buildFilterView(
              isGenderSelected,
              (Gender gender) {
                setState(() {
                  isGenderSelected[gender] = !isGenderSelected[gender]!;
                });
              },
              ageRange,
              (RangeValues values) {
                setState(() {
                  ageRange = values;
                });
              },
              dateRange,
              (DateTimeRange range) {
                setState(() {
                  dateRange = range;
                });
              });
        }));
      },
      icon: Image.asset("assets/icons/ic_filter_gray.png"),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (value) {
        setState(() {
          _pageIndex = value;
        });
      },
      currentIndex: _pageIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black26,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Image.asset("assets/icons/people_filled.png"), label: ""),
        BottomNavigationBarItem(
            icon: Image.asset("assets/icons/home_filled.png"), label: ""),
        BottomNavigationBarItem(
            icon: Image.asset("assets/icons/person_filled.png"), label: ""),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      leading: IconButton(
        icon: Image.asset("assets/icons/ic_arrow_left_back.png"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (BuildContext context) {
                return EventSearchView();
              }),
            );
          },
          icon: Image.asset("assets/icons/search.png"),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (BuildContext context) {
                return MyPage();
              }),
            );
          },
          icon: Image.asset(
            "assets/icons/person_icon.png",
          ),
        ),
        // IconButton( // TODO: 알림 구현 후 활성화 (아이콘 수정 필요)
        //     onPressed: () {},
        //     icon: Image.asset("assets/icons/notic_pointed.png")),
      ],
    );
  }

  Widget buildCurrentLocation() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10 * pt, 12 * pt, 15 * pt, 0),
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
                      fontSize: 19 * pt,
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
            TextButton(
              child: Row(
                children: [
                  Text("지도 보기",
                      style: TextStyle(
                          fontSize: 15 * pt,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(85, 85, 85, 1))),
                  SizedBox(
                    width: 6,
                  ),
                  Image.asset(
                    "assets/icons/map.png",
                    width: 25,
                    height: 25,
                  )
                ],
              ),
              onPressed: () {
                Navigator.pushNamed(context, "map");
              },
            )
          ],
        ),
      ),
    );
  }
}
