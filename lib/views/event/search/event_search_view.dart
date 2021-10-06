import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:prototype2021/handler/event/event_article_handler.dart';
import 'package:prototype2021/model/event/event_dto.dart';
import 'package:prototype2021/handler/event/search_article_handler.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/views/event/detail/event_detail_view.dart';
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
              create: (context) => SearchArticleHandler(),
              child: Consumer(
                builder:
                    (context, SearchArticleHandler searchArticleModel, child) {
                  return Column(
                    children: [
                      // Search Bar

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
                      // Content
                      Expanded(
                          child: searchArticleModel.empty()
                              ? buildMainText("이벤트/동행찾기 게시판에 글을 검색해보세요.")
                              : buildArticleSection(searchArticleModel)),
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }

  // build centerized notice text
  Widget buildMainText(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/search_white.png",
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
                color: Color.fromRGBO(180, 180, 180, 1), fontSize: 16),
          ),
        ],
      ),
    );
  }

  Container buildArticleSection(SearchArticleHandler searchArticleModel) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: TabBarView(
        children: [
          buildArticleView(
              searchArticleModel.eventArticleList, ArticleType.EVENT),
          buildArticleView(
              searchArticleModel.companionArticleList, ArticleType.COMPANION),
        ],
      ),
    );
  }

  Widget buildArticleView(
      List<EventPreviewData> data, ArticleType articleType) {
    EventArticleHandler eventArticleHandler =
        EventArticleHandler.detail(articleType: articleType);

    return data.isEmpty
        ? buildMainText("게시글이 존재하지 않습니다")
        : SingleChildScrollView(
            child: Column(
              children: data
                  .map((e) => RecruitCard(
                        title: e.title,
                        hasContents: false,
                        range: e.period,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                              return EventDetailView(e.id, eventArticleHandler,
                                  eventArticleHandler.articleType);
                            }),
                          );
                        },
                      ))
                  .toList(),
            ),
          );
  }

  Widget buildFloatingSearchBar(SearchArticleHandler searchArticleModel) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final controller = FloatingSearchBarController();

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
          if (!searchArticleModel.loading) {
            searchArticleModel.searchArticles(query);
          }
          // setState(() {});
          // setState(() {
          //   this.previewData = searchArticleModel.eventArticleList;
          // });
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
