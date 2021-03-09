import 'package:flutter/material.dart';
import 'package:prototype2021/templates/borded_button.dart';

class ContentsCard extends StatelessWidget {
  final String preview;
  final String title;
  final String place;
  final String explanation;
  final List<String> tags;
  final String scope;
  final List<int> tendencies;
  final Function onTap;

  const ContentsCard({
    this.preview,
    this.title,
    this.place,
    this.explanation,
    this.tags,
    this.scope,
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
                            child: FlatButton(
                              onPressed: () {
                                print("11");
                              },
                              child: Image.network(
                                'https://cdn140.picsart.com/302038404009201.jpg?type=webp&to=crop&r=256',
                                fit: BoxFit.fill,
                              ), //Image.asset(preview)
                            ),
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
                      SizedBox(height: 1),
                      Text(
                        place,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff707070),
                        ),
                      ),
                      SizedBox(width: 50),
                      Text(
                        explanation,
                        style: TextStyle(
                          fontSize: 10,
                          color: const Color(0xff707070),
                        ),
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
                            Icons.star_border,
                            color: Colors.tealAccent[200],
                          ),
                          Text(
                            scope,
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color(0xff707070),
                            ),
                          )
                        ],
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
