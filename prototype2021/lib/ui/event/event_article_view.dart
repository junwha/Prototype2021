import 'package:prototype2021/model/event_article_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/cards/recruit_card.dart';
import 'package:flutter/material.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';
import 'package:prototype2021/ui/event/event_detail_view.dart';
import 'package:provider/provider.dart';

class EventArticleView extends StatefulWidget {
  EventArticleModel eventArticleModel;
  EventArticleView(this.eventArticleModel);

  @override
  _EventArticleViewState createState() => _EventArticleViewState();
}

class _EventArticleViewState extends State<EventArticleView> {
  @override
  void initState() {
    this.widget.eventArticleModel.loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: ChangeNotifierProvider.value(
        value: this.widget.eventArticleModel,
        child: Consumer(
            builder: (context, EventArticleModel eventArticlesModel, child) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: buildArticles(eventArticlesModel),
              ),
              Container(
                color: Colors.white,
                height: 190,
                child: Column(
                  children: [
                    buildTopNotice(),
                    buildSelectSection(
                        eventArticlesModel), // 현재 위치, 지도보기 / 내 주변 이벤트, 동행 찾기
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget buildArticles(EventArticleModel eventArticlesModel) {
    if (eventArticlesModel.isEventArticleLoading) return Text("Loading ...");
    return Padding(
      padding: const EdgeInsets.only(top: 170, bottom: 500),
      child: Column(
          children: eventArticlesModel.eventArticleList
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                        return EventDetailView(e.id, eventArticlesModel,
                            eventArticlesModel.articleType);
                      }),
                    );
                  },
                  child: RecruitCard(
                    title: e.title,
                    hasContents: false,
                    range: e.period,
                    heartCount: e.hearts,
                    commentCount: e.comments,
                  ),
                ),
              )
              .toList()),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: 35,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.people_alt_outlined,
              color: Colors.black,
              size: 35,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 35,
            )),
      ],
    );
  }

  Padding buildSelectSection(EventArticleModel articleModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15 * pt, 12 * pt, 15 * pt, 30 * pt),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "현재 위치",
                    style: TextStyle(
                        fontSize: 20 * pt, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 40,
                  ),
                ],
              ),
              TextButton(
                child: Row(
                  children: [
                    Text("지도 보기",
                        style: TextStyle(
                            fontSize: 17 * pt,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(85, 85, 85, 1))),
                    SizedBox(
                      width: 6,
                    ),
                    Image.asset(
                      "assets/icons/map.png",
                      width: 25,
                      height: 25,
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "map");
                },
              )
            ],
          ),
          SizedBox(
            height: 6 * pt,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SelectableTextButton(
                      titleName: "내 주변 이벤트",
                      isChecked: articleModel.articleType == ArticleType.EVENT,
                      onPressed: () {
                        setState(() {
                          articleModel.setArticleType(ArticleType.EVENT);
                        });
                      }),
                  SizedBox(width: 10),
                  SelectableTextButton(
                      titleName: "동행찾기",
                      isChecked:
                          articleModel.articleType == ArticleType.COMPANION,
                      onPressed: () {
                        setState(() {
                          articleModel.setArticleType(ArticleType.COMPANION);
                        });
                      }),
                ],
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                IconButton(
                  icon: Image.asset(
                    "assets/icons/filter_list_24px.png",
                    width: 40,
                    height: 40,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.asset(
                    "assets/icons/editor.png",
                    width: 40,
                    height: 40,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "editor");
                  },
                )
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Container buildTopNotice() {
    return Container(
      child: Center(
          child: Row(
        children: [
          Image.asset("assets/icons/message_outlined.png"),
          SizedBox(
            width: 7,
          ),
          Text(
            "울산광역시 불꽃축제(2021-01-04~2021-02-03",
            style: TextStyle(fontSize: 17),
          ),
        ],
      )),
      color: Color.fromRGBO(219, 219, 219, 1),
      width: double.infinity,
      height: 20 * pt,
    );
  }
}
