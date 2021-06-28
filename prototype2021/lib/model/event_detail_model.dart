import 'package:flutter/material.dart';
import 'package:prototype2021/model/article_loader.dart';

class EventDetailModel with ChangeNotifier {
  ArticleLoader articleLoader = ArticleLoader();
  late ArticleDetailData data;
  bool isLoading = false;

  EventDetailModel(int id) {
    loadEventDetail(id);
  }

  void loadEventDetail(int id) async {
    isLoading = true;
    // TODO: add token

    ArticleDetailData? result = await articleLoader.loadArticleDetail(id);
    if (result == null)
      return;
    else
      data = result;
    isLoading = false;
    notifyListeners();
  }

  //TODO: refactor all article related models
}
