import 'package:flutter/material.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/settings/annotations.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/widgets/buttons/selectable_text_button.dart';

abstract class BoardMainSilverMixin {
  @needsImplement
  List<SliverAppBar> Function(BuildContext, bool) buildHeaderSilverBuilder();

  /// 플랜 만들기에서 컨텐츠 리스트에 들어가는 헤더입니다
  ///
  /// titleText를 넣으면 이에 해당하는 title 위젯을 생성합니다
  ///
  /// title이 주어졌다면 titleText로 생성되는 위젯을 오버라이딩합니다
  Container buildListHeader({
    Widget? title,
    Widget? actions,
    String? titleText,
  }) {
    Text defaultTitle = Text(titleText ?? "",
        style: const TextStyle(
            color: const Color(0xffbdbdbd),
            fontWeight: FontWeight.w400,
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontSize: 12.0),
        textAlign: TextAlign.left);
    List<Widget> children = [];
    if (title != null) children.add(title);
    if (titleText != null && title == null) {
      children.add(defaultTitle);
    }
    if (actions != null) children.add(actions);
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: children.length == 1
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
      padding: const EdgeInsets.all(14),
    );
  }

  /* 
   * ListView.seperated 와 본질적으로 같은 로직을 공유합니다
   * List.generate에서 titleNames.length * 2 - 1 을 길이로 넘기는 이유는 
   * divider를 구현하기 위함입니다
   * 아래 titleNames 리스트의 요소들 사이사이에 placeHolder를 끼워 넣는다고 상상해주세요
   * 이제 List.generate에서 iterate할 index들을 생각해보면
   * 짝수 index들 (0, 2, 4, 6...) 은 
   * titleName ("모두보기", "여행지", "카페", "음식점"...) 에 해당할 것이고 
   * 홀수 index들 (1, 3, 5, 7...) 은 placeHolder가 될 것입니다. 
   * 따라서 index가 짝수일 때는 버튼을, 
   * 홀수일 때는 placeHolder에 해당하는 SizedBox를 반환합니다.
   * 또한 titleNames에 실제로 어떤 새로운 요소가 추가된 것은 아니므로, 
   * 버튼에서 titleName을 위해 titleNames에서 인덱싱을 할때 
   * 2로 integer division한 titleNameIndex로 인덱싱 합니다
   * 이때 titleNameIndex는 index가 짝수일 때만 이용되므로 나머지에 대한 생각을 하지 않아도 됩니다
   * 이런식으로 ListView.seperated 와 같은 로직이 구현되는 것입니다
   */
  SingleChildScrollView buildThemeBar({
    void Function(ContentType)? onFilterChange,
    ContentType? currentFilter,
  }) {
    List<String> titleNames = titleContentType.keys.toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(titleNames.length * 2 - 1, (index) {
        int titleNameIndex = index ~/ 2;
        String titleName = titleNames[titleNameIndex];
        bool isChecked = titleContentType[titleName] == currentFilter;
        return index % 2 == 0
            ? TBSelectableTextButton(
                isChecked: isChecked,
                titleName: titleName,
                onPressed: onFilterChange == null
                    ? null
                    : () {
                        onFilterChange(
                          titleContentType[titleName] ?? ContentType.unknown,
                        );
                      },
              )
            : SizedBox(width: 8 * pt);
      })),
    );
  }

  Widget buildTabBar({required void Function(int) onTap}) {
    return TabBar(
      unselectedLabelColor: Color(0xffbdbdbd),
      labelColor: Colors.black,
      indicatorColor: Colors.black,
      indicatorWeight: 1 * pt,
      onTap: onTap,
      tabs: [
        Tab(
          child: Container(
            child: Text(
              '플랜',
              style: TextStyle(
                fontSize: 15 * pt,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Tab(
          child: Text(
            '컨텐츠',
            style: TextStyle(
              fontSize: 15 * pt,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCurrentLocation(
    BuildContext context, {
    required Map<String, String> location,
    required void Function() onLeadingPressed,
  }) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10 * pt, 12 * pt, 15 * pt, 29 * pt),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Row(
                children: [
                  Text(
                    '${location["mainLocation"]} ${location["subLocation"]}',
                    style: TextStyle(
                      color: Color(0xff444444),
                      fontFamily: 'Roboto',
                      fontSize: 23 * pt,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 10 * pt),
                  ImageIcon(
                    AssetImage("assets/icons/ic_area_arrow_down_unfold.png"),
                    color: Colors.black,
                    size: 14 * pt,
                  ),
                ],
              ),
              onPressed: onLeadingPressed,
            ),
            // IconButton(
            //   onPressed: () {
            //     tbShowDialog(
            //         context,
            //         TBLargeDialog(
            //           title: "",
            //           insetsPadding:
            //               EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            //           padding: EdgeInsets.all(20),
            //           body: SingleChildScrollView(child: FilterView()),
            //         ));
            //   },
            //   icon: Image.asset("assets/icons/ic_filter_gray.png"),
            // ),
          ],
        ),
      ),
    );
  }
}
