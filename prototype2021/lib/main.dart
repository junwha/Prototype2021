import 'package:flutter/material.dart';
import 'package:prototype2021/login_page.dart';
import 'package:prototype2021/main_page.dart';
import 'package:prototype2021/board/board_page.dart';

void main() {
  runApp(
    MaterialApp(home: LoginPage(), routes: {
      '/login': (context) => LoginPage(),
      '/main': (context) => MainPage(),
      '/main/board': (context) => BoardPage(),
    }),
  );
}
