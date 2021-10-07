import 'package:flutter/material.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/loader/board/plan_loader.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/views/board/base/board.dart';
import 'package:provider/provider.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({Key? key}) : super(key: key);

  @override
  _WishlistViewState createState() => _WishlistViewState();
}

class _WishlistViewState extends BoardState<WishlistView> {
  _WishlistViewState() : super();

  @override
  PlanLoader planLoader =
      new PlanLoader.withMode(mode: PlanLoaderMode.wishlist);

  @override
  Future<void> getContentsData([
    String? keyword,
    ContentType? type,
    bool reset = false,
  ]) async {
    try {
      UserInfoHandler model =
          Provider.of<UserInfoHandler>(context, listen: false);
      if (model.token != null) {
        contentsDataController.sink
            .add(await contentsLoader.getContentsWishList(
          token: model.token!,
          type: type,
          reset: reset,
        ));
      }
    } catch (error) {
      print("Error from getContentsData: $error");
      // error handle
    }
  }

  @override
  IconButton buildLeading() {
    return IconButton(
      onPressed: onBackButtonPressed,
      icon: Image.asset('assets/icons/ic_arrow_left_back.png'),
    );
  }

  @override
  List<Widget> buildActions() => [];

  @override
  Widget buildTitle() {
    return Text("저장 목록",
        style: const TextStyle(
            color: const Color(0xff000000),
            fontWeight: FontWeight.w400,
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontSize: 15.0),
        textAlign: TextAlign.left);
  }

  @override
  List<SliverAppBar> Function(BuildContext, bool) buildHeaderSilverBuilder() =>
      (BuildContext context, bool innerBoxIsScrolled) {
        List<SliverAppBar> slivers = <SliverAppBar>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            pinned: true,
            backgroundColor: Colors.white,
            title: buildTabBar(onTap: setTabIndex),
          ),
          SliverAppBar(
              automaticallyImplyLeading: false,
              shadowColor: Color(0x29000000),
              forceElevated: true,
              elevation: 3,
              pinned: true,
              backgroundColor: Colors.white,
              title: buildThemeBar(
                onFilterChange: (type) => setCurrentFilter(type),
                currentFilter: currentFilter,
              )),
        ];
        return slivers;
      };

  @override
  Widget? buildBottomNavigationBar() => null;

  @override
  Widget? buildContentsDetail(BuildContext context) => null;

  @override
  void onBackButtonPressed() {
    Navigator.pop(context);
  }
}
