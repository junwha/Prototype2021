import 'package:flutter/material.dart';
import 'package:prototype2021/login_page.dart';
import 'package:prototype2021/main_page.dart';
import 'package:prototype2021/survey/survey_page.dart';

void main() {
  runApp(
    //Don't touch here. route map is in 'main_page.dart'
    MaterialApp(home: LoginPage(), routes: {
      //'/main': (context) => MainPage(),
      '/main': (context) => SurveyPage(),
      '/mainp': (context) => MainPage(),
    }),
  );
}
