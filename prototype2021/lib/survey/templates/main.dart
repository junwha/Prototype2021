import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: LodgingList()));
}

class LodgingList extends StatefulWidget {
  @override
  LodgingListState createState() => LodgingListState();
}

class LodgingListState extends State<LodgingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter List View Tutorial"),
      ),
      body: _buildListView(),
    );
  }
}

Widget _buildListView() {
  var listview = ListView(children: [
    lodgingcard("70,000원", "보안요원있음", "유흥시설인접", "24시간프론트데스크"),
    splitLine(),
    lodgingcard("55,000원", "보안요원있음", "유흥시설인접", "  "),
    splitLine(),
    lodgingcard("60,000원", "보안요원있음", "유흥시설인접", "24시간프론트데스크"),
    splitLine(),
    lodgingcard("65,000원", "보안요원있음", "유흥시설인접", "  "),
    splitLine(),
    lodgingcard("45,000원", "보안요원있음", "유흥시설인접", "24시간프론트데스크"),
    splitLine(),
  ]);
  return listview;
}

Widget splitLine() {
  return Container(
    width: 500,
    height: 0.5,
    color: Colors.grey,
  );
}

Widget lodgingcard(
  String price,
  String text1,
  String text2,
  String text3,
) {
  return Container(
    padding: EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image.network(
          'https://www.urbanbrush.net/web/wp-content/uploads/edd/2018/01/web-20180113082720872081.png',
          width: 80,
          height: 80,
        ),
        SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              price,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: 3),
            Text(
              text1,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
            ),
            SizedBox(height: 3),
            Text(
              text2,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10),
            )
          ],
        ),
        SizedBox(width: 30),
        Text(
          text3,
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
        ),
      ],
    ),
  );
}
