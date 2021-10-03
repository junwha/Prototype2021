import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prototype2021/data/event_dto.dart';
import 'package:prototype2021/loader/article_loader.dart';
import 'package:prototype2021/model/event/search_article_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/widgets/cards/recruit_card.dart';
import 'package:provider/provider.dart';

class EventSearchView extends StatefulWidget {
  const EventSearchView({Key? key}) : super(key: key);

  @override
  _EventSearchViewState createState() => _EventSearchViewState();
}

class _EventSearchViewState extends State<EventSearchView> {
  List<EventPreviewData> previewData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: ChangeNotifierProvider(
              create: (context) => SearchArticleModel(),
              child: Consumer(
                builder:
                    (context, SearchArticleModel searchArticleModel, child) {
                  return Column(
                    children: [
                      // Search Bar
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Image.asset(
                                    "assets/icons/ic_arrow_left_back.png"),
                              ),
                              buildFloatingSearchBar(searchArticleModel),
                            ],
                          ),
                          buildTabBar(),
                        ],
                      ),
                      // Content
                      searchArticleModel.loading != true
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/search_white.png"),
                                  Text(
                                    "이벤트 게시판에 글을 검색해보세요.",
                                    style: TextStyle(
                                        color: Color.fromRGBO(180, 180, 180, 1),
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: buildArticleSection(searchArticleModel)),
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }

  Container buildArticleSection(SearchArticleModel searchArticleModel) {
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: TabBarView(children: [
          SingleChildScrollView(
            child: Column(
              children: searchArticleModel.eventArticleList
                  .map((e) => RecruitCard(
                      title: e.title, hasContents: false, range: e.period))
                  .toList(),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: searchArticleModel.companionArticleList
                  .map((e) => RecruitCard(
                      title: e.title, hasContents: false, range: e.period))
                  .toList(),
            ),
          ),
          // SingleChildScrollView(
          //   child: Column(
          //       children: List.generate(
          //           20,
          //           (index) => GestureDetector(
          //                 onTap: () {
          //                   setState(() {
          //                     this.previewData =
          //                         searchArticleModel.eventArticleList;
          //                   });
          //                 },
          //               ))),
          // ),
          // SingleChildScrollView(
          //     child: Column(
          //         children: List.generate(
          //             20,
          //             (index) => GestureDetector(
          //                   onTap: () {
          //                     setState(() {
          //                       this.previewData =
          //                           searchArticleModel.companionArticleList;
          //                     });
          //                   },
          //                 )))),
        ]));
  }

  Widget buildFloatingSearchBar(SearchArticleModel searchArticleModel) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final controller = FloatingSearchBarController();
    final _applyKey = GlobalKey<FormState>();

    return Container(
      child: FloatingSearchBar(
        // margins: EdgeInsets.only(left: 50),
        shadowColor: Colors.transparent,
        backdropColor: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        height: 45,
        backgroundColor: Color.fromRGBO(106, 126, 166, 1),
        controller: controller,
        title: Row(
          children: [
            Image.asset("assets/icons/search_white.png"),
            SizedBox(
              width: 7,
            ),
            Text(
              '장소, 여행지, 카페, 음식점 검색',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xffc5cddd),
                fontWeight: FontWeight.normal,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
        hint: 'search',
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 16),
        transitionDuration: const Duration(milliseconds: 1000),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 500),
        automaticallyImplyBackButton: false,
        onSubmitted: (query) {
          // Call your model, bloc, controller here.
          searchArticleModel.searchArticles(query);
          setState(() {
            this.previewData = searchArticleModel.eventArticleList;
          });
        },
        onFocusChanged: (bool focus) {},
        // Specify a custom transition to be used for
        // animating between opened and closed stated.
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                //  Navigator.pushNamed(context, '/board/filter');
              },
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //   height: 112,
                  //   width: MediaQuery.of(context).size.width,
                  //   color: Colors.white,
                  //   child: Center(
                  //     child: Text(
                  //       '서비스를 준비중입니다',
                  //       style: TextStyle(
                  //           color: Colors.black, fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
      height: 60,
      width: 300,
    );
  }

  PreferredSizeWidget buildTabBar() {
    return TabBar(
      unselectedLabelColor: Color(0xffbdbdbd),
      labelColor: Colors.black,
      indicatorColor: Colors.black,
      indicatorWeight: 1 * pt,
      tabs: [
        Tab(
          child: Container(
            child: Text(
              '이벤트',
              style: TextStyle(
                fontSize: 12 * pt,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Tab(
          child: Text(
            '동행찾기',
            style: TextStyle(
              fontSize: 12 * pt,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
