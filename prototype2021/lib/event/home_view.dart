import 'package:flutter/material.dart';
import 'package:prototype2021/event/map_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Trip Builder',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        child: RaisedButton(
          child: Text("지도 화면"),
          onPressed: () {
            Navigator.pushNamed(context, '/event_map');
          },
        ),
      ),
    );
  }
}
