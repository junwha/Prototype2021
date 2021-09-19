import 'package:flutter/material.dart';
import 'package:prototype2021/theme/board/app_bar_text_button.dart';
import 'package:prototype2021/theme/rounded_text_field.dart';
import 'package:prototype2021/ui/board/board_main_view.dart';

mixin BoardMainViewAppBarMixin {
  IconButton buildLeading(BuildContext context,
      {required BoardMainViewMode viewMode,
      required void Function(BoardMainViewMode) setViewMode}) {
    Image leadingIcon = viewMode == BoardMainViewMode.search
        ? Image.asset('assets/icons/ic_arrow_left_back.png')
        : Image.asset("assets/icons/ic_remove_x.png");
    void onPressed() {
      switch (viewMode) {
        case BoardMainViewMode.main:
          Navigator.pop(context);
          break;
        case BoardMainViewMode.search:
          setViewMode(BoardMainViewMode.main);
          break;
        case BoardMainViewMode.result:
          setViewMode(BoardMainViewMode.search);
          break;
        default:
          break;
      }
    }

    return IconButton(
      color: Colors.black,
      icon: leadingIcon,
      onPressed: onPressed,
    );
  }

  List<Widget> buildActions(
      {required void Function(BoardMainViewMode) setViewMode,
      required BoardMainViewMode viewMode}) {
    List<Widget> actions = [
      TBAppBarTextButton(
          onPressed: () => setViewMode(BoardMainViewMode.search),
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
    if (viewMode == BoardMainViewMode.search) actions = [];
    if (viewMode == BoardMainViewMode.result) actions.removeAt(0);
    return actions;
  }

  Widget buildTextField(
    TextEditingController textController, {
    required BoardMainViewMode viewMode,
    void Function()? onTap,
    void Function(String?)? onSubmitted,
    void Function(String)? onChanged,
  }) {
    if (viewMode == BoardMainViewMode.main) {
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
