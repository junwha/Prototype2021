import 'package:flutter/material.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/settings/annotations.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/widgets/dialogs/pop_up.dart';
import 'package:prototype2021/widgets/buttons/selectable_text_button.dart';
import 'package:prototype2021/views/board/base/board.dart';
import 'package:prototype2021/views/board/base/filter/filter_view.dart';

abstract class BoardMainSilverMixin {
  List<SliverAppBar> Function(BuildContext, bool) buildHeaderSilverBuilder({
    required void Function() onLeadingPressed,
    required void Function(int) onTabBarPressed,
    required void Function(ContentType?) onFilterBarPressed,
    required int tabIndex,
    required Map<String, String> location,
    required BoardMode viewMode,
  }) =>
      (BuildContext context, bool innerBoxIsScrolled) {
        List<SliverAppBar> slivers = <SliverAppBar>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: Colors.white,
            title: buildCurrentLocation(context,
                location: location, onLeadingPressed: onLeadingPressed),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            pinned: true,
            backgroundColor: Colors.white,
            title: buildTabBar(onTap: onTabBarPressed),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            shadowColor: Color(0x29000000),
            forceElevated: true,
            pinned: true,
            backgroundColor: Colors.white,
            title: buildFilterBar(onFilterChange: onFilterBarPressed),
          )
        ];
        return slivers;
      };

  /// 헤더에서 필요한 컴포넌트만을 뽑는 메소드입니다.
  /// 예를 들어 [BoardMainView]에서는 [BoardMode.search] 일때는 빈 리스트를 반환토록 하고,
  /// [BoardMode.result] 일때는 [defaultSilvers]의 첫번재 아이템을 지워
  /// [buildCurrentLocation] 이 나오지 않도록 합니다.
  ///
  /// 아래는 [defaultSilvers]의 각 인덱스별로 대응되는 위젯입니다.
  ///
  /// 0: [buildCurrentLocation]
  ///
  /// 1: [buildTabBar]
  ///
  /// 2: [buildFilterBar]
  ///
  /// 아래는 BoardMainView에서 [override]된 [processHeaderItems]의 예시입니다.
  ///
  /// ```dart
  /// // if (tabIndex == 1) defaultSlivers.removeAt(2);
  /// if (mode == BoardMode.search) defaultSlivers = [];
  /// if (mode == BoardMode.result) defaultSlivers.removeAt(0);
  /// return defaultSlivers;
  /// ```
  @needsImplement
  List<SliverAppBar> processHeaderItems({
    required List<SliverAppBar> defaultSlivers,
    required BoardMode mode,
    required int tabIndex,
  });

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
  SingleChildScrollView buildFilterBar(
      {void Function(ContentType?)? onFilterChange}) {
    /* 
     * This is a temporary implementation. 
     * focusedIndex should be handled as state at root widget(Board)
     */
    final int focusedIndex = 0;
    const List<String> titleNames = ["모두보기", "여행지", "카페", "음식점", "숙소", "기타"];
    ContentType? titleToContentType(String title) {
      switch (title) {
        case "여행지":
          return ContentType.spot;
        case "숙소":
          return ContentType.accomodations;
        case "음식점":
          return ContentType.restaurants;
        default:
          return null;
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(titleNames.length * 2 - 1, (index) {
        int titleNameIndex = index ~/ 2;
        return index % 2 == 0
            ? TBSelectableTextButton(
                isChecked: titleNameIndex == focusedIndex,
                titleName: titleNames[titleNameIndex],
                onPressed: onFilterChange == null
                    ? null
                    : () => onFilterChange(
                        titleToContentType(titleNames[titleNameIndex])),
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

  Widget buildCurrentLocation(BuildContext context,
      {required Map<String, String> location,
      required void Function() onLeadingPressed}) {
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
            IconButton(
              onPressed: () {
                tbShowDialog(
                    context,
                    TBLargeDialog(
                      title: "",
                      insetsPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                      padding: EdgeInsets.all(20),
                      body: SingleChildScrollView(child: FilterView()),
                    ));
              },
              icon: Image.asset("assets/icons/ic_filter_gray.png"),
            ),
          ],
        ),
      ),
    );
  }
}
