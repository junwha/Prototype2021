import 'package:flutter/material.dart';
import 'package:prototype2021/model/event/event_article_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/cards/timer_card.dart';
import 'package:prototype2021/views/event/editor/editor_view.dart';
import 'package:prototype2021/views/event/detail/event_detail_view.dart';

/// 화면 아래에 이벤트와 관련한 위젯들을 담당하는 믹스인
mixin ContentDetailViewEventMixin {
  /// 이벤트 페이지로 가는 버튼을 렌더링 합니다
  TextButton buildEventNavigatorButton(
    BuildContext context, {
    required void Function() onPressed,
  }) {
    return TextButton(
      child: Container(
          height: 35 * pt,
          width: 280 * pt,
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
              child: Text(
            "이벤트 게시판에서 더보기 ->",
            style: TextStyle(
              color: Color(0xff555555),
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ))),
      onPressed: onPressed,
    );
  }

  /// 이벤트 위젯의 헤더를 렌더링합니다.(글쓰기 버튼 등)
  Padding buildEventArea(
    BuildContext context,
    EventArticleModel articleModel,
  ) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '이 장소 같이 가요',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      "assets/icons/editor.png",
                      width: 40,
                      height: 40,
                    ),
                    onPressed: () async {
                      try {
                        bool result = await Navigator.push(context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                          return EditorView();
                        })) as bool;
                        if (result) {
                          articleModel.loadTopArticles();
                          articleModel.loadArticles();
                        }
                      } catch (e) {}
                    },
                  ),
                  Text(
                    '글 쓰기',
                    style: TextStyle(
                      color: Color(0xff555555),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  /// 이벤트 게시물들을 렌더링합니다
  Widget buildEventArticles(
      BuildContext context, EventArticleModel eventArticleModel) {
    if (eventArticleModel.isTopEventArticleLoading) return Text("Loading ...");
    return Column(
      children: eventArticleModel.topEventArticleList
          .map(
            (e) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                    return EventDetailView(
                        e.id, eventArticleModel, eventArticleModel.articleType);
                  }),
                );
              },
              child: TimerCard(
                title: e.title,
                description: e.summary,
                due: e.period.end,
                onEnd: () {
                  eventArticleModel.loadTopArticles();
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
