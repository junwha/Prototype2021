import 'package:flutter/material.dart';
import 'package:prototype2021/templates/borded_button.dart';

/* 제플린의 e.contents.heart 부분 */

class EventContents extends StatefulWidget {
  @override
  _EventContentsState createState() => _EventContentsState();
}

class _EventContentsState extends State<EventContents> {
  // TODO: 선택 항목을 저장하고, 클릭 시 이를 보여줘야 함.
  // e.content.heartSelect 참고.
  List<int> selectedCards = []; // 선택된 카드의 index를 저장하는 리스트

  @override
  // ContentsCard를 element로 가지는 리스트를 생성한다.
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, int index) {
            return ContentsCard(
              preview: 'fill it!',
              title: '울산대공원',
              place: '대한민국, 울산',
              rating: 3.7,
              ratingNumbers: 369,
              tags: ['액티비티', '관광명소', '인생사진'],
              explanation: '',
            );
          },
        )),
      ],
    );
  }
}

// e.content.heart에 있는 개별 카드 클래스
class ContentsCard extends StatefulWidget {
  final String? preview;

  final String? title;

  final String? place;

  final String? explanation;

  final double? rating;

  final int? ratingNumbers;

  final List<String>? tags;

  const ContentsCard({
    required this.preview,
    required this.title,
    required this.place,
    required this.explanation,
    required this.rating,
    required this.ratingNumbers,
    required this.tags,
  });

  @override
  _ContentsCardState createState() => _ContentsCardState();
}

class _ContentsCardState extends State<ContentsCard> {
  bool isSelected = false;

  late String preview;
  late String title;
  late String place;

  late String explanation;

  late double rating;

  late int ratingNumbers;

  late List<String> tags;

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
              color: isSelected
                  ? Colors.grey.withOpacity(0)
                  : Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(1, 3), // changes position of shadow
            ),
          ],
          // 선택 시 배경 색이 바뀌어야 한다.
          color: isSelected
              ? Color.fromARGB(80, 0, 0, 0)
              : const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),

      //BUG: 빈 공간의 경우 클릭이 동작하지 않음.
      child: GestureDetector(
        onTap: () {
          isSelected = !isSelected;
          setState(() {});
          print(isSelected);
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
                      title = widget.title ?? 'empty',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: const Color.fromARGB(255, 112, 112, 112),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      place = widget.place ?? 'empty',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 112, 112, 112),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      explanation = widget.explanation ?? 'empty',
                      style: TextStyle(
                        fontSize: 10,
                        color: const Color.fromARGB(255, 112, 112, 112),
                      ),
                    ),
                    SizedBox(height: 9),
                    Row(
                      children: [
                        Flex(
                          children: tagMethod(),
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow[600]),
                        SizedBox(width: 3),
                        Text(
                          (rating = widget.rating ?? 0).toString(),
                          style: TextStyle(
                            fontSize: 11,
                            color: const Color(0xff707070),
                          ),
                        ),
                        SizedBox(width: 1),
                        Text(
                          '(' +
                              (ratingNumbers = widget.ratingNumbers ?? 0)
                                  .toString() +
                              ')',
                          style: TextStyle(
                            fontSize: 11,
                            color: const Color(0xff707070),
                          ),
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
          //TODO: Null check
          widget.tags![index],
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
