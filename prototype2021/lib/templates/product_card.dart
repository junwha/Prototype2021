import 'package:flutter/material.dart';
import 'package:prototype2021/templates/borded_button.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final int cost;
  final String period;
  final int companion;
  final String season;
  final String travelType;
  final String preview;
  final List<String> tags;

  const ProductCard(
      {this.title,
      this.cost,
      this.period,
      this.companion,
      this.season,
      this.travelType,
      this.preview,
      this.tags});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      child: Card(
        //margin: EdgeInsets.fromLTRB(8.0, 0, 8.0, 10.0),
        child: Container(
          color: Colors.grey[200],
          height: 160,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
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
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ), //Image.asset(preview),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Text(title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            )),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('비용: $cost원'),
                          SizedBox(width: 50),
                          Text('기간: $period'),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tags.length,
                          itemBuilder: (BuildContext _ctx, int i) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                              child: BordedButton(
                                child: Text(
                                  tags[i],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                                onPressed: () {},
                                radius: 25,
                              ),
                            );
                          },
                        ),
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
