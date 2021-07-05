import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prototype2021/model/search_article_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/cards/recruit_card.dart';
import 'package:provider/provider.dart';

class EventSearchView extends StatefulWidget {
  const EventSearchView({Key? key}) : super(key: key);

  @override
  _EventSearchViewState createState() => _EventSearchViewState();
}

class _EventSearchViewState extends State<EventSearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
            create: (context) => SearchArticleModel(),
            child: Consumer(
              builder: (context, SearchArticleModel searchArticleModel, child) {
                return Stack(
                  children: [
                    searchArticleModel.loading == true
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/icons/search_1.png"),
                                Text(
                                  "이벤트 게시판에 글을 검색해보세요.",
                                  style: TextStyle(
                                      color: Color.fromRGBO(180, 180, 180, 1),
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Column(
                              children: searchArticleModel.articleList
                                  .map((e) => RecruitCard(
                                      title: e.title,
                                      hasContents: false,
                                      range: e.period))
                                  .toList(),
                            ),
                          ),
                    buildFloatingSearchBar(searchArticleModel),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                  ],
                );
              },
            )),
      ),
    );
  }

  Widget buildFloatingSearchBar(SearchArticleModel searchArticleModel) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final controller = FloatingSearchBarController();
    final _applyKey = GlobalKey<FormState>();

    return FloatingSearchBar(
      margins: EdgeInsets.only(left: 50),
      shadowColor: Colors.transparent,
      backdropColor: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      height: 45,
      backgroundColor: const Color(0xFFEDECEC),
      controller: controller,
      title: Row(
        children: [Icon(Icons.search), Text('이벤트 게시판에 글을 검색해보세요.')],
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
    );
  }
}
