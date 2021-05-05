import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 550,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "센토사섬",
                    style: TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.comment),
                ],
              ),
            ),
            Image.network(
              "https://res.klook.com/images/fl_lossy.progressive,q_65/c_fill,w_1200,h_630,f_auto/w_80,x_15,y_15,g_south_west,l_klook_water/activities/ainz5sko4wmjsgiehuaq/[%ED%81%B4%EB%A3%A9%20%EB%8B%A8%EB%8F%85]%20%EC%8B%B1%EA%B0%80%ED%8F%AC%EB%A5%B4%20%EC%84%BC%ED%86%A0%EC%82%AC%EC%84%AC%20%EB%B2%84%EC%8A%A4%20%ED%88%AC%EC%96%B4.jpg",
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: myBoxDecoration(1.4, 25),
                    child: Text(
                      "관광지 소개",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세. 무궁화 삼천리 화려강산 대한사람 대한으로 길이 보전하세. 남산 위에 저 소나무 철갑을 두른 듯",
                    style: TextStyle(height: 1.9),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  buildRow(),
                  SizedBox(
                    height: 12,
                  ),
                  buildRow(),
                ],
              ),
            ),
          ],
        ));
  }

  Row buildRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_box,
          color: Colors.tealAccent[200],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "케이블 카 운영 시간",
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "08 : 45 ~ 21 : 30",
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  BoxDecoration myBoxDecoration(double width, double radius) {
    return BoxDecoration(
      border: Border.all(width: width),
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    );
  }
}
