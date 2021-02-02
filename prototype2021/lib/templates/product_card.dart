import 'package:flutter/material.dart';
import 'package:prototype2021/templates/borded_button.dart';

class ProductCard extends StatelessWidget {
  final String preview;
  final String title;
  final int cost;
  final String period;
  final List<String> tags;
  final int matchPercent;
  final List<int> tendencies;
  final Function onTap;

  const ProductCard({
    this.preview,
    this.title,
    this.cost,
    this.period,
    this.tags,
    this.matchPercent,
    this.tendencies,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/board/info');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        child: Container(
          color: const Color(0xFFF3F3F3),
          height: 170,
          child: Row(
            children: <Widget>[
              //Ratio is 1:2 which is determined by each flex arguments
              //Preview Section
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 15),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: Image.network(
                              'https://cdn140.picsart.com/302038404009201.jpg?type=webp&to=crop&r=256',
                              fit: BoxFit.fill,
                            ), //Image.asset(preview)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Information Section
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: const Color(0xff707070),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '비용: $cost원',
                            style: TextStyle(
                              color: const Color(0xff707070),
                            ),
                          ),
                          SizedBox(width: 50),
                          Text(
                            '기간: $period',
                            style: TextStyle(
                              color: const Color(0xff707070),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 25,
                        child: Row(
                          children: List<Widget>.generate(
                            3,
                            (index) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: BordedButton(
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      tags[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 100,
                                        color: const Color(0xff707070),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  radius: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.check_box,
                            color: Colors.tealAccent[200],
                          ),
                          Text(
                            '여행 스타일 일치도: $matchPercent%',
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color(0xff707070),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: List<Widget>.generate(
                            3,
                            (index) => Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: Icon(Icons.ac_unit, size: 30),
                                )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
