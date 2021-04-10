import 'package:flutter/material.dart';
import 'package:prototype2021/templates/borded_button.dart';

/* 제플린의 e.contents.heart 부분 */

class EventPlan extends StatefulWidget {
  @override
  _EventPlanState createState() => _EventPlanState();
}

class _EventPlanState extends State<EventPlan> {
  @override
  // ProductCard를 element로 가지는 리스트를 생성한다.
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, int index) {
            return ProductCard(
              // TODO: preview 추가
              title: '중국 도장 깨기',
              place: '대한민국, 울산',
              matchPercent: 92,
              cost: 20000,
              period: '2박3일',
              tags: ['액티비티', '관광명소', '인생사진'],
            );
          },
        )),
      ],
    );
  }
}

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
    this.preview,
    this.title,
    this.place,
    this.tags,
    this.matchPercent,
    this.cost,
    this.period,
    this.tendencies,
    this.onTap,
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

      //BUG: 빈 공간의 경우 클릭이 동작하지 않음.
      child: GestureDetector(
        onTap: () {
          setState(() {});
        },
        child: ClipRect(
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
                        fit: BoxFit.fill,
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
                    SizedBox(height: 2),
                    Text(
                      widget.place,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 112, 112, 112),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
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
                    SizedBox(height: 5),
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
                      height: 5,
                    ),
                    Row(children: [
                      // FIXME: 실제 아이콘으로 채우기
                      // Icon(Icons.check_circle_outline_rounded),
                    ]),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Flex(
                          children: tagMethod(),
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> tagMethod() {
    // 태그 박스 구현 코드
    return List<Widget>.generate(
      3,
      (index) => Container(
        padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: const Color.fromARGB(255, 219, 219, 219), width: 1)),
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
