import 'package:flutter/material.dart';
import 'package:prototype2021/tap_pages/home_page.dart';
import 'package:prototype2021/tap_pages/add_page.dart';
import 'package:prototype2021/tap_pages/community_page.dart';
import 'package:prototype2021/templates/sub_navigator.dart';
import 'package:prototype2021/board/board_page.dart';
import 'package:prototype2021/board/info_page.dart';
import 'package:prototype2021/myplan/myplan_page.dart';
import 'package:flutter/services.dart';
import 'package:prototype2021/board/sub_pages/filter_page.dart';

GlobalKey<NavigatorState> homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
GlobalKey<NavigatorState> addNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'add');
GlobalKey<NavigatorState> communityNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'comu');

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  //Set all routes in here
  Map<String, Widget> homeRouteMap = {
    '/': HomePage(),
    '/board': BoardPage(),
    '/board/info': InfoPage(),
    '/board/filter': FilterPage(),
    '/myplan': MyPlanPage(),
  };
  Map<String, Widget> addRouteMap = {'/': AddPage()};
  Map<String, Widget> communityRouteMap = {'/': CommunityPage()};

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    homeNavigatorKey,
    addNavigatorKey,
    communityNavigatorKey,
  ];

  Future<bool> _systemBackButtonPressed() {
    if (_navigatorKeys[_index].currentState.canPop()) {
      _navigatorKeys[_index]
          .currentState
          .pop(_navigatorKeys[_index].currentContext);
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: FlatButton(
              onPressed: () => _systemBackButtonPressed(),
              child: Icon(Icons.arrow_back_ios)),
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
          child: IndexedStack(
            index: _index,
            children: <Widget>[
              SubNavigator(
                  routeMap: homeRouteMap, getKey: () => homeNavigatorKey),
              SubNavigator(
                  routeMap: addRouteMap, getKey: () => addNavigatorKey),
              SubNavigator(
                  routeMap: communityRouteMap,
                  getKey: () => communityNavigatorKey),
            ],
          ),
        ),
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
                icon: Icon(Icons.add_box_outlined, size: 40.0), label: '여행 계획'),
            BottomNavigationBarItem(
                icon: Icon(Icons.people, size: 40.0), label: '커뮤니티'),
          ],
        ),
      ),
    );
  }
}
