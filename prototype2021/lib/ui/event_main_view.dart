import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/recruit_card.dart';
import 'package:prototype2021/theme/timer_card.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';

class EventMainView extends StatefulWidget {
  @override
  _EventMainViewState createState() => _EventMainViewState();
}

class _EventMainViewState extends State<EventMainView> {
  List<bool> isChecked = [true, false];
  var _pageIndex = 0;
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
              icon: Icon(
                Icons.people_alt_sharp,
                size: 40,
              ),
              label: ""),
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
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.fromLTRB(15 * pt, 12 * pt, 15 * pt, 12 * pt),
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
          RecruitCard(
              title: "태화강 근처",
              hasContents: true,
              range: DateTimeRange(
                  start: DateTime(2021, 5, 23, 3, 10),
                  end: DateTime(2021, 5, 25, 3, 10))),
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
        ],
      ),
    );
  }
}
