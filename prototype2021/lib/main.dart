import 'package:flutter/material.dart';
import 'package:prototype2021/ui/event/event_main_view.dart';
import 'package:prototype2021/ui/event/editor_view.dart';
import 'package:prototype2021/ui/event/map_view.dart';
import 'package:prototype2021/ui/event/select_location_view.dart';

void main() {
  runApp(
    //Don't touch here. route map is in 'main_page.dart'
    MaterialApp(home: EventMainView(), routes: {
      'select_location': (context) => SelectLocationView(),
      'map': (context) => MapView(),
      //'/main': (context) => MainPage(),
    }),
  );
}
