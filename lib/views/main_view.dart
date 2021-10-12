import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<String> images = [
    'https://t3.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/2fG8/image/InuHfwbrkTv4FQQiaM7NUvrbi8k.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Hong_Kong_Night_view.jpg/450px-Hong_Kong_Night_view.jpg'
  ];
  double image_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScreenUtilInit(
          designSize: Size(3200, 1440),
          builder: () {
            return SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildImageArea(),
                SizedBox(
                  height: 40,
                ),
                buildIconButtonArea(),
                SizedBox(
                  height: 50,
                ),
                makeImage(BoxFit.fill),
                SizedBox(
                  height: 50,
                ),
                buildPlanRecommendation(
                    "주목! 인플루언서 여행 플랜\n체험하고 싶다면?", SizedBox()),
                SizedBox(
                  height: 40,
                ),
                Container(
                    width: double.infinity,
                    child: Image.asset('assets/icons/img_home_adbanner.png')),
                SizedBox(
                  height: 50,
                ),
                buildPlanRecommendation("가이드 단체 수십명이 떠난\n바로 그 플랜", SizedBox()),
                SizedBox(
                  height: 40,
                ),
                buildBottomArea()
              ],
            ));
          }),
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
              height: 450,
              viewportFraction: 1,
            ),
            items: images.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/icons/img_home_topbanner.png",
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

  Padding buildIconButton(
      String text, Function()? onpressed, Image image, double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        children: [
          IconButton(
            onPressed: onpressed,
            icon: image,
          ),
          Text(text)
        ],
      ),
    );
  }

  Widget makeImage(BoxFit option) {
    return Container(
      child: Image.asset('assets/icons/img_home_dogimage.png',
          width: MediaQuery.of(context).size.width, height: 340, fit: option),
    );
  }

  Row buildIconButtonArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildIconButton("내주변여행", () {
          Navigator.pushNamed(context, 'event');
        }, Image.asset('assets/icons/ic_home_location_event.png'), 15),
        buildIconButton("마이플랜", () {
          Navigator.pushNamed(context, 'wishlist');
        }, Image.asset('assets/icons/ic_home_myplan.png'), 15),
        buildIconButton("여행게시판", () {
          Navigator.pushNamed(context, 'board');
        }, Image.asset('assets/icons/ic_home_board.png'), 15),
        buildIconButton("플랜제작", () {
          Navigator.pushNamed(context, 'planmake');
        }, Image.asset('assets/icons/ic_home_myprofile.png'), 15),
      ],
    );
  }

  Padding buildPlanRecommendation(String title, Widget widget) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Image.asset('assets/icons/ic_home_section.png'),
        SizedBox(
          height: 10,
        ),

        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        // TO DO : 인플루언서 여행 플랜 카드 슬라이더 구현
        widget
      ]),
    );
  }

  Container buildBottomArea() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Color.fromRGBO(244, 244, 248, 1),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          "트립빌더 (Trip Builder)  |  대표 김명준\n사업자 등록번호 892-79-00273\n울산광역시 울주군 언양읍 유니스트길 50, 307동 1층 (UNISPARK)",
          style: TextStyle(fontSize: 11),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildIconButton("", () {
              linkToUrl("https://www.instagram.com/teamtripbuilder/");
            }, Image.asset('assets/icons/ic_home_instagram.png'), 5),
            buildIconButton(
                "", () {}, Image.asset('assets/icons/ic_home_blog.png'), 5),
            buildIconButton("", () {
              linkToUrl("https://www.facebook.com/teamtripbuilder/");
            }, Image.asset('assets/icons/ic_home_facebook.png'), 5),
          ],
        ),
      ]),
    );
  }

  void linkToUrl(String url) async {
    if (await canLaunch(url)) await launch(url);
  }
}
