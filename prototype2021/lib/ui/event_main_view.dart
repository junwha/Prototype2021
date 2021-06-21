import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/recruit_card.dart';
import 'package:prototype2021/theme/timer_card.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EventMainView extends StatefulWidget {
  @override
  _EventMainViewState createState() => _EventMainViewState();
}

class _EventMainViewState extends State<EventMainView> {
  List<bool> isChecked = [true, false];
  var images = [
    'https://t3.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/2fG8/image/InuHfwbrkTv4FQQiaM7NUvrbi8k.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Hong_Kong_Night_view.jpg/450px-Hong_Kong_Night_view.jpg'
  ];
  var _pageIndex = 0;
  double image_index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(15 * pt, 12 * pt, 15 * pt, 30 * pt),
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
                                  color: Colors.grey)),
                          Icon(Icons.map_sharp, size: 25),
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
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.view_array_outlined,
                              size: 38,
                            ),
                            Icon(
                              Icons.departure_board_outlined,
                              size: 32,
                            )
                          ]),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
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
            ),
            SizedBox(
              height: 30,
            ),
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
                onPressed: () {},
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
                    ))))
          ],
        ),
      ),
    );
  }
}
