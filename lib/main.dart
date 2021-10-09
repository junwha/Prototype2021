import 'package:flutter/material.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/views/board/main/board_main_view.dart';
import 'package:prototype2021/views/board/plan/make/plan_make_view.dart';
import 'package:prototype2021/views/event/editor/editor_view.dart';
import 'package:prototype2021/views/event/main/event_main_view.dart';
import 'package:prototype2021/views/login/login_view.dart';
import 'package:prototype2021/views/event/map/map_view.dart';
import 'package:prototype2021/views/event/map/select_location_map_view.dart';
import 'package:prototype2021/views/main_view.dart';
import 'package:prototype2021/views/mypage/wishlist_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    //Don't touch here. route map is in 'main_page.dart'
    ChangeNotifierProvider(
      create: (_) => UserInfoHandler(),
      child: MaterialApp(
        routes: {
          'login': (context) => LoginView(),
          'editor': (context) => EditorView(),
          'select_location': (context) => SelectLocationMapView(),
          'map': (context) => MapView(),
          'event': (context) => EventMainView(),
          'wishlist': (context) => WishlistView(),
          'board': (context) => BoardMainView(),
          'planmake': (context) => PlanMakeView(),
          'main': (context) => MainView(),
        },
        initialRoute: 'login',
      ),
    ),
  );
}
