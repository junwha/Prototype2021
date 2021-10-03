import 'package:flutter/material.dart';
import 'package:html/dom.dart' show Document;
import 'package:html/parser.dart' show parse;

/// 리스트에 있는 아이템 중에서 첫번째로 발견된 null이 아닌 아이템을 반환합니다
/// 리스트에 있는 아이템이 전부 null이라면 null을 반환합니다.
T? pickNonNull<T>(List<T?> items) {
  T? result;
  for (int i = 0; i < items.length; i++) {
    if (items[i] != null) {
      result = items[i];
      break;
    }
  }
  return result;
}

/// 기본적으로 HTML태그를 떼어내는 작업을 하는 함수입니다
/// 특정 태그들은 태그를 없애는 대신 다른 문자로 대체하는데,
/// 아래와 같이 태그를 교체합니다
///
/// <br>, <br /> -> "\n"
/// <strong>, </strong> -> "**"
String htmlToStringContent(String source) {
  source = source.replaceAll(RegExp("<[ ]*br[ ]*\/*[ ]*>"), "\n");
  source = source.replaceAll(RegExp("<[ ]*\/*[ ]*strong[ ]*>"), "\n");
  Document document = parse(source);
  return parse(document.body?.text ?? "").documentElement?.text ?? source;
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
