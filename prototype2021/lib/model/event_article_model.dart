import 'package:flutter/material.dart';
import 'package:prototype2021/model/article_loader.dart';

class EventArticleModel with ChangeNotifier {
  ArticleLoader articleLoader = ArticleLoader();
  List<EventPreviewData> eventArticleList = [];
  bool isEventArticleLoading = false;
  ArticleDetailData? detailData;

  EventArticleModel() {
    loadEventArticles();
  }

  EventArticleModel.detail(int id) {
    loadEventDetail(id);
  }

  void loadEventArticles() async {
    isEventArticleLoading = true;
    // TODO: add token
    eventArticleList = await articleLoader.loadEventArticles();
    isEventArticleLoading = false;
    notifyListeners();
  }

  void loadEventDetail(int id) async {
    // TODO: add token

    ArticleDetailData? result = await articleLoader.loadArticleDetail(id);
    if (result == null) {
      print("Article Load failed"); // TODO: move to exception page
      return;
    } else {
      detailData = result;
    }
    notifyListeners();
  }
}
