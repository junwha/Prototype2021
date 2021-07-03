import 'package:flutter/material.dart';
import 'package:prototype2021/model/article_loader.dart';

class EventArticleModel with ChangeNotifier {
  ArticleLoader articleLoader = ArticleLoader();
  List<EventPreviewData> eventArticleList = [];
  bool isEventArticleLoading = false;

  EventArticleModel() {
    loadEventArticles();
  }

  void loadEventArticles() async {
    isEventArticleLoading = true;
    // TODO: add token
    eventArticleList = await articleLoader.loadEventArticles();
    isEventArticleLoading = false;
    notifyListeners();
  }
}
