import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TopNoticeSlider extends StatefulWidget {
  @override
  _TopNoticeSlider createState() => _TopNoticeSlider();
}

class _TopNoticeSlider extends State<TopNoticeSlider> {
  List<String> content = [
    "울산광역시 불꽃축제(2021-01-04~2021-02-03)",
    "벚꽃축제 in 울산대공원(2021-04-25~2021-05-01)"
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
