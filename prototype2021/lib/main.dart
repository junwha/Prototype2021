import 'package:flutter/material.dart';
import 'package:prototype2021/ui/event_main_view.dart';
import 'package:prototype2021/ui/editor_view.dart';
import 'package:prototype2021/ui/map_view.dart';
import 'package:prototype2021/ui/select_location_view.dart';

void main() {
  runApp(
    //Don't touch here. route map is in 'main_page.dart'
    MaterialApp(home: EventMainView(), routes: {
      'select_location': (context) => SelectLocationView(),
      'editor': (context) => EditorView(),
      //'/main': (context) => MainPage(),
    }),
  );
}
