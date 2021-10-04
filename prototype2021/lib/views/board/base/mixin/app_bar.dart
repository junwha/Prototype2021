import 'package:flutter/material.dart';
import 'package:prototype2021/settings/annotations.dart';
import 'package:prototype2021/widgets/textfields/rounded_text_field.dart';
import 'package:prototype2021/views/board/base/board.dart';

mixin BoardAppBarMixin {
  @needsImplement
  IconButton buildLeading();

  @needsImplement
  List<Widget> buildActions();

  Widget buildTextField(
    TextEditingController textController, {
    required BoardMode viewMode,
    void Function()? onTap,
    void Function(String?)? onSubmitted,
    void Function(String)? onChanged,
  }) {
    if (viewMode == BoardMode.main) {
      return SizedBox();
    }
    return RoundedTextField(
      textController: textController,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      hintText: "지역, 맛집, 키워드를 검색해보세요.",
      prefixIcon: Image.asset("assets/icons/ic_main_search.png"),
    );
  }
}
