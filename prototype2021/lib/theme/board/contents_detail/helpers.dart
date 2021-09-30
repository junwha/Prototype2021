import 'package:flutter/material.dart';

/// 리스트에 있는 아이템 중에서 null이 아닌 item이 있으면 이를 반환,
/// 그렇지 않다면 null을 반환한다.
T? pickNonNull<T>(List<T?> items) {
  T? result;
  items.forEach((item) {
    if (item != null) {
      result = item;
    }
  });
  return result;
}

/// 페이지에 들어가야하는 여러 자잘한 메서드들의 모임
mixin ContentDetailViewHelpers {
  /// 페이지에 들어가는 구분선을 렌더링합니다
  Container buildLineArea() {
    return Container(
      width: double.infinity,
      height: 1,
      color: Color(0xffe8e8e8),
    );
  }
}
