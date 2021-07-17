import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BoardDetailView extends StatefulWidget {
  const BoardDetailView();

  @override
  BoardDetailViewState createState() => BoardDetailViewState();
}

class BoardDetailViewState extends State<BoardDetailView> {
  double image_index = 0;
  List<String> images = [
    'https://t3.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/2fG8/image/InuHfwbrkTv4FQQiaM7NUvrbi8k.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Hong_Kong_Night_view.jpg/450px-Hong_Kong_Night_view.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
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
            Container(
              width: double.infinity,
              height: 1,
              color: Color(0xffe8e8e8),
            ),
            buildTextArea(),
            Container(
              width: double.infinity,
              height: 1,
              color: Color(0xffe8e8e8),
            ),
            buildPriceArea()
          ],
        ),
      ),
    );
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
}
