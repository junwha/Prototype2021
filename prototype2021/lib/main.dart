import 'package:flutter/material.dart';
import 'package:prototype2021/ui/editor_view.dart';
import 'package:prototype2021/view/e_map_view.dart';

void main() {
  runApp(
    //Don't touch here. route map is in 'main_page.dart'
    MaterialApp(home: EditorView(), routes: {
      //'/main': (context) => MainPage(),
    }),
  );
}
