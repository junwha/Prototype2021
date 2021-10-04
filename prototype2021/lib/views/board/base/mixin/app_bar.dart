import 'package:flutter/material.dart';
import 'package:prototype2021/widgets/textfields/rounded_text_field.dart';
import 'package:prototype2021/views/board/base/mixin/app_bar_text_button.dart';
import 'package:prototype2021/views/board/base/board.dart';

mixin BoardAppBarMixin {
  IconButton buildLeading(
    BuildContext context, {
    required BoardMode viewMode,
    required void Function() onPressed,
  }) {
    Image leadingIcon = viewMode == BoardMode.search
        ? Image.asset('assets/icons/ic_arrow_left_back.png')
        : Image.asset("assets/icons/ic_remove_x.png");

    return IconButton(
      color: Colors.black,
      icon: leadingIcon,
      onPressed: onPressed,
    );
  }

  List<Widget> buildActions(
      {required void Function(BoardMode) setViewMode,
      required BoardMode viewMode}) {
    List<Widget> actions = [
      TBAppBarTextButton(
          onPressed: () => setViewMode(BoardMode.search),
          icon: Image.asset("assets/icons/ic_main_search.png"),
          text: "검색"),
      TBAppBarTextButton(
          onPressed: () {},
          icon: Image.asset("assets/icons/ic_main_heart_default.png"),
          text: "찜목록"),
      TBAppBarTextButton(
          onPressed: () {},
          icon: Image.asset("assets/icons/ic_hamburger_menu.png"),
          text: "메뉴"),
    ];
    if (viewMode == BoardMode.search) actions = [];
    if (viewMode == BoardMode.result) actions.removeAt(0);
    return actions;
  }

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
