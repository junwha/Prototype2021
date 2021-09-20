import 'package:flutter/material.dart';
import 'package:prototype2021/loader/contents_loader.dart';
import 'package:prototype2021/loader/plan_loader.dart';
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
  const HeartButton({
    Key? key,
    required this.isHeartSelected,
    required this.heartFor,
    required this.dataId,
    required this.userId,
  }) : super(key: key);

  @override
  _HeartButtonState createState() =>
      _HeartButtonState(heartSelected: isHeartSelected);
}

class _HeartButtonState extends State<HeartButton>
    with PlanLoader, ContentsLoader {
  bool heartSelected;
  void setHeartSelected(bool _heartSelected) => setState(() {
        heartSelected = _heartSelected;
      });
  void onHeartPressed() async {
    bool success = await handleHeartPressed(
        heartFor: widget.heartFor, heartSelected: heartSelected);
    if (success) setHeartSelected(!heartSelected);
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
      final String token = "token from somewhere";
      switch (heartFor) {
        case HeartFor.planCard:
          await heartPlan(widget.dataId.toString(), token);
          break;
        case HeartFor.contentCard:
          await heartContents(widget.dataId.toString(), token);
          break;
        default:
          break;
      }
      return true;
    } catch (error) {
      // Silently passing the error...
      return false;
    }
  }
}
