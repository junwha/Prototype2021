import 'package:flutter/material.dart';
import 'package:prototype2020/tap_pages/home_page.dart';
import 'package:prototype2020/tap_pages/add_page.dart';
import 'package:prototype2020/tap_pages/community_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _index = 0;
  var _tapPages = [HomePage(), AddPage(), CommunityPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading:
            FlatButton(onPressed: () {}, child: Icon(Icons.arrow_back_ios)),
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
      body: _tapPages[_index],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 40.0), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined, size: 40.0), label: '추가'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people, size: 40.0), label: '추가'),
        ],
      ),
    );
  }
}
