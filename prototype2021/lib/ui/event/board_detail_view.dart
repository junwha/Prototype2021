import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:prototype2021/model/event_article_model.dart';
import 'package:provider/provider.dart';
import 'package:prototype2021/ui/event/editor_view.dart';
import 'package:prototype2021/ui/event/event_detail_view.dart';
import 'package:prototype2021/theme/cards/timer_card.dart';
import 'package:prototype2021/settings/constants.dart';

class BoardDetailView extends StatefulWidget {
  const BoardDetailView();

  @override
  BoardDetailViewState createState() => BoardDetailViewState();
}

class BoardDetailViewState extends State<BoardDetailView> {
  double image_index = 0;
  bool isAllList = false;

  List<String> images = [
    'https://t3.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/2fG8/image/InuHfwbrkTv4FQQiaM7NUvrbi8k.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Hong_Kong_Night_view.jpg/450px-Hong_Kong_Night_view.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
            child: ChangeNotifierProvider(
          create: (context) => EventArticleModel.main(),
          child: Consumer(
              builder: (context, EventArticleModel eventArticleModel, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '울산대공원',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                  'assets/icons/ic_main_heart_default.png'))
                        ],
                      ),
                      Text(
                        '대한민국, 울산',
                        style: TextStyle(
                          color: Color(0xff707070),
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Image.asset('assets/icons/ic_pc_star_big.png'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '3.7 (369)',
                            style: TextStyle(
                              color: Color(0xff707070),
                              fontSize: 15,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      buildTags(),
                      SizedBox(
                        height: 18,
                      ),
                      buildImageArea(),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                buildLineArea(),
                buildTextArea(),
                buildLineArea(),
                buildPriceArea(),
                buildLineArea(),
                buildTimeArea(),
                buildLineArea(),
                buildLocationArea(),
                buildLineArea(),
                buildEventArea(eventArticleModel),
                buildEventArticles(eventArticleModel),
                TextButton(
                    child: Container(
                        height: 35 * pt,
                        width: 280 * pt,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          "이벤트 게시판에서 더보기 ->",
                          style: TextStyle(
                            color: Color(0xff555555),
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ))),
                    onPressed: () {
                      if (!isAllList) {
                        setState(() {
                          isAllList = true;
                        });
                      } else {
                        // TODO: next page
                      }
                    })
              ],
            );
          }),
        )));
  }

  AppBar buildAppBar() {
    return AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/ic_hamburger_menu.png'))
        ],
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: Image.asset("assets/icons/ic_arrow_left_back.png"),
          onPressed: () {},
        ),
        title: Text("컨텐츠 정보",
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xff000000),
              fontSize: 17,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            )));
  }

  Row buildTags() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0),
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1)),
          child: Text(
            "액티비티",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: const Color(0xff707070),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0),
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1)),
          child: Text(
            "관광명소",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: const Color(0xff707070),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0),
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1)),
          child: Text(
            "인생사진",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: const Color(0xff707070),
            ),
          ),
        ),
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
                    child: Image.asset(
                      "assets/icons/imagebar2.png",
                      fit: BoxFit.cover,
                      scale: 20,
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

  Container buildLineArea() {
    return Container(
      width: double.infinity,
      height: 1,
      color: Color(0xffe8e8e8),
    );
  }

  Padding buildTextArea() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Text(
            '다양한 놀이 기구와 운동 시설을 갖춘 도심 공원, 울산대공원',
            style: TextStyle(
              height: 1.3,
              color: Color(0xff010101),
              fontSize: 21,
              letterSpacing: 1.5,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            '울산대공원은 울산광역시 남구 대공원로 94에 있으며, 옥동과 신정동에 걸쳐 있는 도심 공원이다. 전체 면적은 약364만여m2이고, 시설 면적은 79만m2이다. 공원 정문 쪽에는 소규모 워터파크와 수영장 시설을 갖추고 있는 아쿠아시스가 입지하고 있다. 공원 정문과 동문 사이에 현충탑이 자리잡고 있으며, 매년 6월 6일에 현충탑 앞에서 추념식이 열린다. 정문, 남문, 동문 모두 자전거 대여소가 있어 자전거 대여를 할 수 있다.',
            style: TextStyle(
              color: Colors.black,
              height: 1.5,
              fontSize: 15,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }

  Padding buildPriceArea() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("이용료",
                  style: const TextStyle(
                      color: const Color(0xff080808),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      letterSpacing: 1.5,
                      fontSize: 17.0)),
              SizedBox(
                width: 4,
              ),
              Text(
                "유료",
                style: const TextStyle(
                    color: const Color(0xff004af7),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    letterSpacing: 1.5,
                    fontSize: 17.0),
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text(
              '성인 20유로 (홈페이지 예약 시, 19유로) \n 만 11세 이하 무료\n사전 예매 가능 (홈페이지)\n00 카드 소지 시 30% 할인',
              style: TextStyle(
                color: Color(0xff707070),
                height: 1.9,
                fontSize: 15,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left),
        ],
      ),
    );
  }

  Padding buildTimeArea() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('영업 시간, 휴무일',
                style: TextStyle(
                    color: Color(0xff080808),
                    fontSize: 17,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5),
                textAlign: TextAlign.left),
            SizedBox(
              height: 3,
            ),
            Text(
                "일 09:00 - 21:00\n월 휴무\n화 09:00 - 21:00\n수 09:00 - 21:00\n목 09:00 - 21:00\n금 09:00 - 21:00\n토 09:00 - 21:00\n",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  height: 1.9,
                  color: Color(0xff707070),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.left)
          ],
        ),
      ),
    );
  }

  Padding buildLocationArea() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '위치 및 가는 법',
            style: TextStyle(
              color: Color(0xff080808),
              fontSize: 17,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Image.asset('assets/icons/mapimage.png'),
          SizedBox(
            height: 10,
          ),
          RichText(
              text: new TextSpan(children: [
            new TextSpan(
                text: "주소 ",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff040404),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "Amusementstreet 1, 1071 XX Sanghai\n",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0x80080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "가는 방법 ",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "장궈이 역에서 도보 5분 거리\n",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0x80080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "전화 ",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "+31206747000\n",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0x80080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "홈페이지 ",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xff080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
            new TextSpan(
                text: "https://portal.unist.ac.kr/irj/portal",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0x80080808),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    height: 2)),
          ]))
        ],
      ),
    );
  }

  Padding buildEventArea(EventArticleModel articleModel) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '이 장소 같이 가요',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      "assets/icons/editor.png",
                      width: 40,
                      height: 40,
                    ),
                    onPressed: () async {
                      try {
                        bool result = await Navigator.push(context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                          return EditorView();
                        })) as bool;
                        if (result) {
                          articleModel.loadTopArticles();
                          articleModel.loadArticles();
                        }
                      } catch (e) {}
                    },
                  ),
                  Text(
                    '글 쓰기',
                    style: TextStyle(
                      color: Color(0xff555555),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildEventArticles(EventArticleModel eventArticleModel) {
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
}
