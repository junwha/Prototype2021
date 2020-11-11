import 'package:flutter/material.dart';
import 'package:prototype2020/login_page.dart';
import 'package:prototype2020/main_page.dart';

void main() {
  runApp(
    MaterialApp(home: LoginPage(), routes: {
      '/login': (context) => LoginPage(),
      '/main': (context) => MainPage(),
    }),
  );
}
