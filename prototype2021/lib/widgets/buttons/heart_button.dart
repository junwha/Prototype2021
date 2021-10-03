import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prototype2021/views/board/loader/contents_loader.dart';
import 'package:prototype2021/views/board/loader/plan_loader.dart';
import 'package:prototype2021/model/simple_storage.dart';
import 'package:prototype2021/settings/constants.dart';

enum HeartFor {
  planCard,
  contentCard,
}

class HeartButton extends StatefulWidget {
  final bool isHeartSelected;
  final HeartFor heartFor;
  final int dataId;
  final int userId;
  final String token;
  const HeartButton({
    Key? key,
    required this.isHeartSelected,
    required this.heartFor,
    required this.dataId,
    required this.token,
    required this.userId,
  }) : super(key: key);

  @override
  _HeartButtonState createState() =>
      _HeartButtonState(heartSelected: isHeartSelected);
}

class _HeartButtonState extends State<HeartButton> {
  bool heartSelected;
  PlanLoader planLoader = PlanLoader();
  ContentsLoader contentsLoader = ContentsLoader();

  void setHeartSelected(bool _heartSelected) => setState(() {
        heartSelected = _heartSelected;
      });
  void onHeartPressed() async {
    try {
      bool success = await handleHeartPressed(
          heartFor: widget.heartFor, heartSelected: heartSelected);
      if (success) {
        setHeartSelected(!heartSelected);
        return;
      }
      throw HttpException("Unexpected error");
    } catch (error) {
      print(error);
    }
  }

  _HeartButtonState({required this.heartSelected});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onHeartPressed,
      icon: buildHeartIcon(),
      iconSize: 30 * pt,
    );
  }

  Image buildHeartIcon() {
    String heartFilledPath = "assets/icons/ic_product_heart_fill.png";
    String heartDefaultPath = "assets/icons/ic_product_heart_default.png";

    return Image.asset(heartSelected ? heartFilledPath : heartDefaultPath);
  }

  Future<bool> handleHeartPressed({
    required HeartFor heartFor,
    required bool heartSelected,
  }) async {
    try {
      switch (heartFor) {
        case HeartFor.planCard:
          await planLoader.heartPlan(widget.dataId.toString(), widget.token);
          break;
        case HeartFor.contentCard:
          await contentsLoader.heartContents(
              widget.dataId.toString(), widget.token);
          break;
        default:
          break;
      }
      return true;
    } catch (error) {
      print(error);
      // Silently passing the error...
      return false;
    }
  }
}
