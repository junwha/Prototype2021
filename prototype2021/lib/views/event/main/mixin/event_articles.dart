import 'package:prototype2021/model/event/event_article_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/widgets/cards/recruit_card.dart';
import 'package:flutter/material.dart';
import 'package:prototype2021/widgets/buttons/selectable_text_button.dart';
import 'package:prototype2021/views/event/detail/event_detail_view.dart';
import 'package:provider/provider.dart';

class EventArticles extends StatefulWidget {
  EventArticleModel eventArticleModel;
  EventArticles(this.eventArticleModel);

  @override
  _EventArticlesState createState() => _EventArticlesState();
}

class _EventArticlesState extends State<EventArticles> {
  @override
  void initState() {
    this.widget.eventArticleModel.loadArticles();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: this.widget.eventArticleModel,
      child: Consumer(
          builder: (context, EventArticleModel eventArticlesModel, child) {
        return SingleChildScrollView(
          child: buildArticles(eventArticlesModel),
        );
      }),
    );
  }

  Widget buildArticles(EventArticleModel eventArticlesModel) {
    if (eventArticlesModel.isEventArticleLoading) return Text("Loading ...");
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 30),
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
}
