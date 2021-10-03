import 'package:flutter/material.dart';
import 'package:prototype2021/views/board/plan/make/home/plan_make_home_view.dart';

mixin PlanMakeHomeHelper on State<PlanMakeHomeView> {
  bool onScrollNotificationHandler(
      ScrollNotification scrollNotification,
      AnimationController scrollController,
      bool onTop,
      void Function(bool) setOnTop) {
    if (scrollNotification.metrics.pixels < 1) {
      // When screen is on top
      if (!onTop) {
        setOnTop(true);
        scrollController.reverse();
      }
    } else {
      // When screen is not on top
      if (onTop) {
        setOnTop(false);
        scrollController.forward();
      }
    }
    return false;
  }
}
