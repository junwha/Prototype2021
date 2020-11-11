import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final int cost;
  final String period;
  final int companion;
  final String season;
  final String travelType;
  final String preview;

  const ProductCard(
      {this.title,
      this.cost,
      this.period,
      this.companion,
      this.season,
      this.travelType,
      this.preview});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 0, 16.0, 10.0),
      child: Container(
        height: 130,
        child: Row(children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(
                    'https://cdn140.picsart.com/302038404009201.jpg?type=webp&to=crop&r=256',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ), //Image.asset(preview),
          Expanded(
              flex: 5,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${cost}원'),
                            Text('${companion}인'),
                            Text(travelType)
                          ],
                        ),
                        SizedBox(width: 50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text(period), Text(season)],
                        )
                      ],
                    ),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
