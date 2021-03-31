import 'package:flutter/material.dart';
import 'package:prototype2021/login_page.dart';
import 'package:prototype2021/main_page.dart';
import 'package:prototype2021/event/home_view.dart';
import 'package:prototype2021/event/map_view.dart';

void main() {
  runApp(
    //Don't touch here. route map is in 'main_page.dart'
    MaterialApp(home: LoginPage(), routes: {
      //'/main': (context) => MainPage(),
      '/main': (context) => HomeView(),
      '/mainp': (context) => MainPage(),
      '/event_map': (context) => MapView(),
    }),
  );
}
