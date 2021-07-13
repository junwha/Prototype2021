import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';

/// e.content.heart에 있는 개별 카드 클래스
class ContentsCard extends StatefulWidget {
  final String preview;
  final String title;
  final String place;
  final String explanation;
  final double rating;
  final int ratingNumbers;
  final List<String> tags;
  final bool clickable;
  final EdgeInsets margin;
  final int heartCounts;
  final Function(bool)? onHeartPreessed;
  final bool isHeartSelected;

  const ContentsCard({
    required this.preview,
    required this.title,
    required this.place,
    required this.explanation,
    required this.rating,
    required this.ratingNumbers,
    required this.tags,
    this.clickable = true,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.heartCounts = 3,
    this.onHeartPreessed,
    this.isHeartSelected = false,
  });

  @override
  _ContentsCardState createState() => _ContentsCardState();
}

class _ContentsCardState extends State<ContentsCard> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.widget.clickable) {
          isSelected = !isSelected;
          setState(() {});
          print(isSelected);
        }
      },
      child: Container(
        padding: EdgeInsets.all(20 * pt),
        height: 160 * pt,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xffe8e8e8),
            width: 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            //Ratio is 1:2 which is determined by each flex arguments
            // 이미지 담는 공간.

            //Information Section
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18 * pt,
                      color: Color(0xff444444),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    widget.place,
                    style: TextStyle(
                      color: Color(0xff555555),
                      fontSize: 10 * pt,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      //BUG: 클릭시 색이 같이 변하지 않음.
                      Image.asset(
                        "assets/icons/ic_pc_star_small.png",
                      ),
                      SizedBox(width: 3),
                      Text(
                        '${widget.rating.toString()} (${widget.ratingNumbers.toString()})',
                        style: TextStyle(
                          color: Color(0xff555555),
                          fontSize: 10 * pt,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      SizedBox(width: 12 * pt),
                      Image.asset("assets/icons/ic_pc_heart_small.png"),
                      SizedBox(width: 3),
                      Text(
                        '${widget.rating.toString()} (${widget.ratingNumbers.toString()})',
                        style: TextStyle(
                          color: Color(0xff555555),
                          fontSize: 10 * pt,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6 * pt),
                  Text(
                    widget.explanation,
                    maxLines: 2,
                    style: TextStyle(
                      color: Color(0xff555555),
                      fontSize: 10 * pt,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: 10 * pt),
                  Row(
                    children: [
                      Flex(
                        children: tagMethod(isSelected, widget.tags),
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15 * pt,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(9.0)),
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    width: 100 * pt,
                    height: 120 * pt,
                    color: Colors.black,
                    child: Image.network(
                      this.widget.preview,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (this.widget.onHeartPreessed != null)
                        this
                            .widget
                            .onHeartPreessed!
                            .call(this.widget.isHeartSelected);
                    },
                    icon: Image.asset(
                      this.widget.isHeartSelected
                          ? "assets/icons/ic_product_heart_fill.png"
                          : "assets/icons/ic_product_heart_default.png",
                    ),
                    iconSize: 30 * pt,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

//TODO: ContentsCard와 중복되는 리팩터링 필요.
/// 2.4.2 (저장한 플랜)의 카드 클래스.
class ProductCard extends StatefulWidget {
  final String preview;
  final String title;
  final String place;
  final List<String> tags;
  final int matchPercent;
  final int cost;
  final String period;
  final List<int> tendencies;
  final Function onTap;

  const ProductCard({
    required this.preview,
    required this.title,
    required this.place,
    required this.tags,
    required this.matchPercent,
    required this.cost,
    required this.period,
    required this.tendencies,
    required this.onTap,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 15, 0, 15),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      //FIXME: Icon 크기 때문에 임시로 170으로 설정해 뒀음. 바꿔야 할 것 같다.
      height: 170,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(1, 3),
            ),
          ],
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),

      child: Row(
        children: <Widget>[
          //Ratio is 1:2 which is determined by each flex arguments
          // 이미지 담는 공간.
          Expanded(
            flex: 1,
            child: Column(
              // TODO: 이미지에 하트 넣어야 함.
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  child: Image.network(
                    'https://cdn140.picsart.com/302038404009201.jpg?type=webp&to=crop&r=256',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 13,
          ),
          //Information Section
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: const Color.fromARGB(255, 112, 112, 112),
                  ),
                ),
                SizedBox(height: 5 * pt),
                Text(
                  widget.place,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 112, 112, 112),
                  ),
                ),
                SizedBox(height: 4 * pt),
                Row(
                  children: [
                    // FIXME: 실제 아이콘으로 바꾸기.
                    // Icon(Icons.check_circle_outline_rounded),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      '여행 스타일 ' + widget.matchPercent.toString() + '% 일치',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 112, 112, 112),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6 * pt),
                Row(
                  children: [
                    Text(
                      '비용: ' + widget.cost.toString() + '원',
                      style: TextStyle(
                        fontSize: 10,
                        color: const Color.fromARGB(255, 112, 112, 112),
                      ),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      '기간: ' + widget.period,
                      style: TextStyle(
                        fontSize: 10,
                        color: const Color.fromARGB(255, 112, 112, 112),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 6 * pt,
                ),
                Row(children: [
                  // FIXME: 실제 tendencies 아이콘으로 채우기
                  // Icon(Icons.check_circle_outline_rounded),
                ]),
                SizedBox(
                  height: 8 * pt,
                ),
                Row(
                  children: [
                    Flex(
                      children: tagMethod(
                          false,
                          widget.tags.length > 3
                              ? widget.tags.sublist(0, 2)
                              : widget.tags),
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> tagMethod(bool isSelected, List<String> tags) {
  // 태그 박스 구현 코드
  return List<Widget>.generate(
    tags.length,
    (index) => Container(
      padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
      decoration: BoxDecoration(
          color: isSelected ? Colors.black.withOpacity(0) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: isSelected
                  ? Colors.black.withOpacity(0.1)
                  : const Color.fromARGB(255, 219, 219, 219),
              width: 1)),
      child: Text(
        tags[index],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: const Color(0xff707070),
        ),
      ),
    ),
  );
}
