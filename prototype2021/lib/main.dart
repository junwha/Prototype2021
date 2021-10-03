import 'package:flutter/material.dart';
import 'package:prototype2021/model/user_info_model.dart';
import 'package:prototype2021/ui/event/editor_view.dart';
import 'package:prototype2021/ui/login/login_view.dart';
import 'package:prototype2021/ui/event/map_view.dart';
import 'package:prototype2021/ui/event/select_location_map_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    //Don't touch here. route map is in 'main_page.dart'
    ChangeNotifierProvider(
      create: (_) => UserInfoModel(),
      child: MaterialApp(
        routes: {
          'login': (context) => LoginView(),
          'editor': (context) => EditorView(),
          'select_location': (context) => SelectLocationMapView(),
          'map': (context) => MapView(),
          //'/main': (context) => MainPage(),
        },
        initialRoute: 'login',
      ),
    ),
  );
}
