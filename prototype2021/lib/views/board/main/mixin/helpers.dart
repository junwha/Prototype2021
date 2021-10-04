import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/widgets/cards/contents_card.dart';
import 'package:prototype2021/widgets/cards/product_card.dart';

mixin BoardMainViewHelpers {
  /* 
   * These functions simulates the api call
  */
  Future<List<ProductCardBaseProps>> getPseudoPlanData(
      [void Function(bool)? setHeartSelected, bool? heartSelected]) async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
        10,
        (index) => new ProductCardBaseProps(
              id: index,
              preview: placeHolder,
              title: "중국 도장깨기",
              place: '상하이(중국), 베이징(중국), 광저우(중국)',
              period: 3,
              costStart: 3,
              costEnd: 5,
              matchPercent: 34,
              tags: ["액티비티", "관광명소", "인생사진"],
              tendencies: [],
              isGuide: index % 2 == 0,
            ));
  }

  Future<List<ContentsCardBaseProps>> getPseudoContentData(
      [void Function(bool)? setHeartSelected, bool? heartSelected]) async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
        10,
        (index) => new ContentsCardBaseProps(
              hearted: false,
              heartCount: 3,
              id: index,
              backgroundColor: Colors.white,
              preview: placeHolder,
              title: "울산대공원",
              place: "대한민국, 울산",
              explanation: "다양한 놀이 기구와 운동 시설을 갖춘 도심 공원, 울산대공원'",
              tags: ["액티비티", "관광명소", "인생사진"],
            ));
  }
}
