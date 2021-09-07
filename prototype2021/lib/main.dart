import 'package:flutter/material.dart';
import 'package:prototype2021/ui/board/board_main_view.dart';
import 'package:prototype2021/ui/event/event_main_view.dart';
import 'package:prototype2021/ui/event/editor_view.dart';
import 'package:prototype2021/ui/login/login_view.dart';
import 'package:prototype2021/ui/event/map_view.dart';
import 'package:prototype2021/ui/event/select_location_map_view.dart';
import 'package:prototype2021/ui/planmake_save.dart';

void main() {
  runApp(
    //Don't touch here. route map is in 'main_page.dart'
    MaterialApp(
      routes: {
        'login': (context) => PlanmakeSaveView(),
        'editor': (context) => EditorView(),
        'select_location': (context) => SelectLocationMapView(),
        'map': (context) => MapView(),
        //'/main': (context) => MainPage(),
      },
      initialRoute: 'login',
    ),
  );
}
