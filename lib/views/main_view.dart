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
      body: SingleChildScrollView(
          child: Column(
        children: [
          buildImageArea(),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildIconButton("내주변여행", () {},
                  Image.asset('assets/icons/ic_home_location_event.png')),
              buildIconButton("마이플랜", () {},
                  Image.asset('assets/icons/ic_home_myplan.png')),
              buildIconButton("여행게시판", () {},
                  Image.asset('assets/icons/ic_home_board.png')),
              buildIconButton("마이프로필", () {},
                  Image.asset('assets/icons/ic_home_myprofile.png')),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          makeImage(BoxFit.fill),
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

  Padding buildIconButton(String text, Function()? onpressed, Image image) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
    return Stack(children: [
      Container(
        child: Image.asset('assets/icons/img_home_dogimage.png',
            width: 340, height: 330, fit: option),
        padding: EdgeInsets.only(
          left: 60,
          right: 0,
        ),
      ),
      Text("data")
    ]);
  }
}
