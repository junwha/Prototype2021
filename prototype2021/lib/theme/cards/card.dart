import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/tag.dart';

/// e.content.heart에 있는 개별 카드 클래스
class ContentsCard extends StatefulWidget {
  final String preview;
  final String title;
  final String place;
  final String explanation;
  final double rating;
  final int ratingNumbers;
  final List<String> tags;
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
    // TODO: Change to required
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.heartCounts = 3,
    this.onHeartPreessed,
    this.isHeartSelected = false,
  });

  @override
  _ContentsCardState createState() => _ContentsCardState();
}

class _ContentsCardState extends State<ContentsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      children: tagMethod(widget.tags),
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
  final int costStart;
  final int costEnd;
  final int period;
  final List<int> tendencies;
  final Function(bool)? onHeartPreessed;
  final bool isHeartSelected;
  final bool isGuide;
  const ProductCard({
    required this.preview,
    required this.title,
    required this.place,
    required this.tags,
    required this.matchPercent,
    required this.costStart,
    required this.costEnd,
    required this.period,
    required this.tendencies,
    this.onHeartPreessed,
    this.isHeartSelected = false,
    this.isGuide = false,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18 * pt,
                        color: Color(0xff444444),
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 8 * pt),
                    this.widget.isGuide
                        ? ContentTag(tagName: "가이드")
                        : SizedBox(),
                  ],
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
                  height: 12 * pt,
                ),
                Text(
                  "기간: ${widget.period}일",
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(0xff555555),
                    fontSize: 12 * pt,
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(height: 4 * pt),
                Text(
                  '예산: ${widget.costStart}~${widget.costEnd}만원',
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(0xff555555),
                    fontSize: 12 * pt,
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(height: 14 * pt),
                Row(
                  children: [
                    Flex(
                      children: tagMethod(widget.tags),
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
    );
  }
}

List<Widget> tagMethod(List<String> tags) {
  // 태그 박스 구현 코드
  return List<Widget>.generate(
    tags.length,
    (index) => Container(
      padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1)),
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
