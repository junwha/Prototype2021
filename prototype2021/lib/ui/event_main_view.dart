import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/recruit_card.dart';
import 'package:prototype2021/theme/timer_card.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class EventMainView extends StatefulWidget {
  @override
  _EventMainViewState createState() => _EventMainViewState();
}

class _EventMainViewState extends State<EventMainView> {
  List<bool> isChecked = [true, false];
  List<String> images = [
    'https://t3.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/2fG8/image/InuHfwbrkTv4FQQiaM7NUvrbi8k.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Hong_Kong_Night_view.jpg/450px-Hong_Kong_Night_view.jpg'
  ];
  int _pageIndex = 0;
  double image_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildTopNotice(),
            buildSelectSection(), // 현재 위치, 지도보기 / 내 주변 이벤트, 동행 찾기
            buildImageArea(),
            SizedBox(
              height: 30,
            ),
            buildArticleList(context)
          ],
        ),
      ),
    );
  }

  Column buildArticleList(BuildContext context) {
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
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14 * pt),
                ),
              ],
            ),
          ),
        ),
        TimerCard(
          title: "태화강 근처",
          description: "낚시하실분 ㅎㅎ",
          due: DateTime(2021, 5, 24, 6, 23, 00),
          onEnd: () {
            print("asdf");
          },
        ),
        TimerCard(
          title: "울산대 공원에서 피맥해요!",
          description: "경치보면서 같이 힐링해요 ㅎㅎ잘 먹는 분이면 더 좋습니다!",
          due: DateTime(2021, 5, 24, 6, 23, 00),
          onEnd: () {
            print("asdf");
          },
        ),
        TimerCard(
          title: "울산 불꽃 축제 같이 가실분?",
          description: "사진 찍고 같이 선물 받아요~~!",
          due: DateTime(2021, 5, 24, 6, 23, 00),
          onEnd: () {
            print("asdf");
          },
        ),
        TextButton(
            child: Container(
                height: 35 * pt,
                width: 280 * pt,
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                    child: Text(
                  "더보기",
                  style: TextStyle(
                      fontSize: 15 * pt,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Second();
                }),
              );
            }),
      ],
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
                  image_index = i.toDouble();
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
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList()),
        DotsIndicator(
          dotsCount: images.length,
          position: image_index,
        )
      ],
    );
  }

  Padding buildSelectSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15 * pt, 12 * pt, 15 * pt, 30 * pt),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "현재 위치",
                    style: TextStyle(
                        fontSize: 20 * pt, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 40,
                  ),
                ],
              ),
              Row(
                children: [
                  Text("지도 보기",
                      style: TextStyle(
                          fontSize: 17 * pt,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(85, 85, 85, 1))),
                  IconButton(
                    icon: Image.asset(
                      "assets/icons/map.png",
                      width: 25,
                      height: 25,
                    ),
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 6 * pt,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SelectableTextButton(
                      titleName: "내 주변 이벤트",
                      isChecked: isChecked[0],
                      onPressed: () {
                        setState(() {
                          isChecked[1] = false;
                          isChecked[0] = true;
                        });
                      }),
                  SizedBox(width: 10),
                  SelectableTextButton(
                      titleName: "동행찾기",
                      isChecked: isChecked[1],
                      onPressed: () {
                        setState(() {
                          isChecked[1] = true;
                          isChecked[0] = false;
                        });
                      }),
                ],
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                IconButton(
                  icon: Image.asset(
                    "assets/icons/filter_list_24px.png",
                    width: 40,
                    height: 40,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.asset(
                    "assets/icons/editor.png",
                    width: 40,
                    height: 40,
                  ),
                  onPressed: () {},
                )
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Container buildTopNotice() {
    return Container(
      child: Center(
          child: Row(
        children: [
          Image.asset("assets/icons/message_outlined.png"),
          SizedBox(
            width: 7,
          ),
          Text(
            "울산광역시 불꽃축제(2021-01-04~2021-02-03",
            style: TextStyle(fontSize: 17),
          ),
        ],
      )),
      color: Color.fromRGBO(219, 219, 219, 1),
      width: double.infinity,
      height: 20 * pt,
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
            icon: Icon(Icons.people_alt_sharp, size: 40), label: ""),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 40,
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              size: 40,
            ),
            label: ""),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (BuildContext context) {
                return EventSearchPage();
              }),
            );
          },
          icon: Image.asset("assets/icons/search.png"),
        ),
        SizedBox(
          width: 20,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
                  return MyPage();
                }),
              );
            },
            padding: EdgeInsets.all(0),
            icon: Image.asset("assets/icons/person_outlined@2x.png"),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Image.asset("assets/icons/notic_pointed.png")),
      ],
    );
  }
}

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 35,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.people_alt_outlined,
                  color: Colors.black,
                  size: 35,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                  size: 35,
                )),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            RecruitCard(
              title: '울산대 공원에서 간단히 피맥해요!',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 01, 05),
                  start: DateTime.utc(2020, 01, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '벚꽃놀이 하러가요',
              range: DateTimeRange(
                  end: DateTime.utc(2021, 01, 05),
                  start: DateTime.utc(2021, 01, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '명장스시 가실 분?',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 02, 15),
                  start: DateTime.utc(2020, 02, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '태화강에서 치맥 하실분 구해요!',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 01, 06),
                  start: DateTime.utc(2020, 01, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '태화강에서 치맥 하실분 구해요!',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 01, 06),
                  start: DateTime.utc(2020, 01, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '태화강에서 치맥 하실분 구해요!',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 01, 06),
                  start: DateTime.utc(2020, 01, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '태화강에서 치맥 하실분 구해요!',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 01, 06),
                  start: DateTime.utc(2020, 01, 04)),
              hasContents: false,
            ),
            RecruitCard(
              title: '태화강에서 치맥 하실분 구해요!',
              range: DateTimeRange(
                  end: DateTime.utc(2020, 01, 06),
                  start: DateTime.utc(2020, 01, 04)),
              hasContents: false,
            ),
          ],
        )));
  }
}

class EventSearchPage extends StatefulWidget {
  const EventSearchPage({Key? key}) : super(key: key);

  @override
  _EventSearchPageState createState() => _EventSearchPageState();
}

class _EventSearchPageState extends State<EventSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/search_1.png"),
                  Text(
                    "이벤트 게시판에 글을 검색해보세요.",
                    style: TextStyle(
                        color: Color.fromRGBO(180, 180, 180, 1), fontSize: 16),
                  ),
                ],
              ),
            ),
            buildFloatingSearchBar(context),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
          ],
        ),
      ),
    );
  }

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final controller = FloatingSearchBarController();
    final _applyKey = GlobalKey<FormState>();

    return FloatingSearchBar(
      margins: EdgeInsets.only(left: 50),
      shadowColor: Colors.transparent,
      backdropColor: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      height: 45,
      backgroundColor: const Color(0xFFEDECEC),
      controller: controller,
      title: Row(
        children: [Icon(Icons.search), Text('여행을 떠나보세요')],
      ),
      hint: 'search',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 16),
      transitionDuration: const Duration(milliseconds: 1000),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      automaticallyImplyBackButton: false,
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      onFocusChanged: (bool focus) {},
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              //  Navigator.pushNamed(context, '/board/filter');
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(
                    height: 112,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Search Result Test',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ));
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          centerTitle: false,
          title: Text(
            "내정보",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 85,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "임시 저장한 글",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(68, 68, 68, 1)),
                      ),
                    ],
                  ),
                )),
            Container(
                width: double.infinity,
                height: 85,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "내가 쓴 글",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(68, 68, 68, 1)),
                      ),
                    ],
                  ),
                )),
            Container(
                width: double.infinity,
                height: 85,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "내가 찜한 글",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(68, 68, 68, 1)),
                      ),
                    ],
                  ),
                )),
          ],
        )));
  }
}
