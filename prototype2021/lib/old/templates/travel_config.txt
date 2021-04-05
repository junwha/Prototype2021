import 'package:flutter/material.dart';
import 'package:prototype2021/survey/templates/lodgingcard.dart';
import 'package:prototype2021/templates/borded_button.dart';

/* XD 6.2.2에 해당 */

class TravelConfig extends StatefulWidget {
  final String preview;
  final String title;
  final String place;
  final List<String> explanation;
  final double rating;
  final int ratingNumbers;
  final List<String> tags;

  const TravelConfig({
    this.preview,
    this.title,
    this.place,
    this.explanation,
    this.rating,
    this.ratingNumbers,
    this.tags,
  });

  @override
  _TravelConfigState createState() => _TravelConfigState();
}

class _TravelConfigState extends State<TravelConfig> {
  bool favoriteSelected = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(15.0, 80.0, 15.0, 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          SizedBox(height: 1),
          Text(
            widget.place,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: const Color(0xff707070),
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow[600]),
              SizedBox(width: 3),
              Text(
                widget.rating.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xff707070),
                ),
              ),
              SizedBox(width: 3),
              Text(
                '(' + widget.ratingNumbers.toString() + ')',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xff707070),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Flex(
                children: tagMethod(),
                direction: Axis.horizontal,
              ),
              Spacer(),
              InkWell(
                child: favoriteButton(favoriteSelected),
                onTap: () {
                  setState(() {
                    favoriteSelected = !favoriteSelected;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(1.0),
            child: AspectRatio(
              aspectRatio: 5 / 3,
              child: Image(
                image: AssetImage('assets/images/login_background.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          //TODO: 여기에 넣기

          SizedBox(height: 15),
          splitLine(),
          SizedBox(height: 5),
          PopsnsFeed(favoriteSelected: favoriteSelected),
          SizedBox(height: 15),
          spotExplain(widget.explanation),
          SizedBox(height: 40),
          splitLine(),
          SizedBox(height: 15),
          costExplain(widget.explanation),
          SizedBox(height: 40),
          splitLine(),
          SizedBox(height: 15),
          openingExplain(widget.explanation),
        ],
      ),
    );
  }

  List<Widget> tagMethod() {
    return List<Widget>.generate(
      3,
      (index) => Container(
        padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 1)),
        child: Text(
          widget.tags[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
            color: const Color(0xff707070),
          ),
        ),
      ),
    );
  }
}

Widget favoriteButton(favoriteSelected) {
  if (favoriteSelected == false) {
    return Container(child: Icon(Icons.favorite_border, color: Colors.black));
  } else {
    return Container(child: Icon(Icons.favorite, color: Colors.red[600]));
  }
}

Widget snsButton(snsSelected) {
  if (snsSelected == false) {
    return Container(child: Icon(Icons.arrow_drop_down_circle_outlined));
  } else {
    return Container(child: Icon(Icons.arrow_right_alt_rounded));
  }
}

class PopsnsFeed extends StatefulWidget {
  final bool favoriteSelected;

  const PopsnsFeed({this.favoriteSelected});

  @override
  _PopsnsFeedState createState() => _PopsnsFeedState();
}

class _PopsnsFeedState extends State<PopsnsFeed> {
  bool snsSelected = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        width: 400,
        height: widget.favoriteSelected ? 30 : 0,
        duration: Duration(milliseconds: 150),
        curve: Curves.linear,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    child: Text('SNS 피드에 게시된 유저들의 사진과 후기 보기',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ))),
                SizedBox(width: 20),
                InkWell(
                  child: snsButton(snsSelected),
                  onTap: () {
                    setState(() {
                      snsSelected = !snsSelected;
                    });
                  },
                )
              ],
            ),
            //TODO: 화살표 누를 경우 SNS 후기 카드들이 popup 되는 부분 구현해야 함.
            SizedBox(height: 5),
            splitLine()
          ],
        ));
  }
}

Widget spotExplain(explanation) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 300,
        child: Text(
          explanation[0],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      SizedBox(height: 10),
      Text(
        explanation[1],
        style: TextStyle(
          fontSize: 13,
          height: 2.0,
        ),
      ),
    ],
  );
}

Widget costExplain(explanation) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 300,
        child: Text(
          explanation[2],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      SizedBox(height: 10),
      Text(
        explanation[3],
        style: TextStyle(
            fontSize: 12,
            height: 2.0,
            color: const Color(0xff707070),
            fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget openingExplain(explanation) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 300,
        child: Text(
          explanation[4],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      SizedBox(height: 10),
      Text(
        explanation[5],
        style: TextStyle(
            fontSize: 12,
            height: 2.0,
            color: const Color(0xff707070),
            fontWeight: FontWeight.bold),
      ),
    ],
  );
}

//TODO: 위치 및 가는 법, 추천 컨텐츠 구현해야 함.
