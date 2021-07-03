import 'package:prototype2021/model/event_article_model.dart';
import 'package:prototype2021/theme/cards/recruit_card.dart';
import 'package:flutter/material.dart';
import 'package:prototype2021/ui/event/event_detail_view.dart';
import 'package:provider/provider.dart';

class EventArticleView extends StatefulWidget {
  EventArticleView();

  @override
  _EventArticleViewState createState() => _EventArticleViewState();
}

class _EventArticleViewState extends State<EventArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ChangeNotifierProvider(
        create: (context) => EventArticleModel(),
        child: Consumer(
            builder: (context, EventArticleModel eventArticlesModel, child) {
          return SingleChildScrollView(
              child: buildArticles(eventArticlesModel));
        }),
      ),
    );
  }

  Widget buildArticles(EventArticleModel eventArticlesModel) {
    if (eventArticlesModel.isEventArticleLoading) return Text("Loading ...");
    return Column(
        children: eventArticlesModel.eventArticleList
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                      return EventDetailView(e.id);
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
            .toList());
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
}
