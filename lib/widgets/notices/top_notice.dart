import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TopNoticeSlider extends StatefulWidget {
  @override
  _TopNoticeSlider createState() => _TopNoticeSlider();
}

class _TopNoticeSlider extends State<TopNoticeSlider> {
  List<String> content = [
    "안녕하세요, 현재 서비스 오픈 테스트를 진행하고 있습니다.",
    "11월 중순 정식 배포가 이루어질 예정입니다.",
    "쉽고 빠른 여행을 위한 나만의 여행 앱, 트립빌더"
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 25.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          disableCenter: false,
          viewportFraction: 1,
          aspectRatio: 1),
      items: content.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              child: Center(
                  child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset("assets/icons/ic_hbg_megaphone.png"),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    "$i",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              )),
              color: Color.fromRGBO(219, 219, 219, 1),
              width: double.infinity,
              height: 20,
            );
          },
        );
      }).toList(),
    );
  }
}
