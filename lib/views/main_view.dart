import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImageArea(),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildIconButton("내주변여행", () {},
                  Image.asset('assets/icons/ic_home_location_event.png'), 15),
              buildIconButton("마이플랜", () {},
                  Image.asset('assets/icons/ic_home_myplan.png'), 15),
              buildIconButton("여행게시판", () {},
                  Image.asset('assets/icons/ic_home_board.png'), 15),
              buildIconButton("마이프로필", () {},
                  Image.asset('assets/icons/ic_home_myprofile.png'), 15),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          makeImage(BoxFit.fill),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.asset('assets/icons/ic_filter_minus_black.png'),
              SizedBox(
                height: 10,
              ),

              Text(
                "주목! 인플루언서 여행 플랜\n체험하고 싶다면?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              // TO DO : 인플루언서 여행 플랜 카드 슬라이더 구현
              SizedBox(
                height: 50,
              ),
            ]),
          ),
          Container(
            height: 200,
            width: double.infinity,
            color: Color.fromRGBO(244, 244, 248, 1),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "트립빌더 (Trip Builder)  |  대표 김명준\n사업자 등록번호 892-79-00273\n울산광역시 울주군 언양읍 유니스트길 50, 307동 1층 (UNISPARK)",
                style: TextStyle(fontSize: 11),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildIconButton("", () {},
                      Image.asset('assets/icons/ic_home_instagram.png'), 5),
                  buildIconButton("", () {},
                      Image.asset('assets/icons/ic_home_blog.png'), 5),
                  buildIconButton("", () {},
                      Image.asset('assets/icons/ic_home_facebook.png'), 5),
                ],
              ),
            ]),
          ),
        ],
      )),
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
          width: 340, height: 330, fit: option),
      padding: EdgeInsets.only(
        left: 50,
        right: 0,
      ),
    );
  }
}
