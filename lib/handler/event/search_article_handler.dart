import 'package:flutter/material.dart';
import 'package:prototype2021/model/event/event_dto.dart';
import 'package:prototype2021/loader/event/article_loader.dart';
import 'package:prototype2021/settings/constants.dart';

class SearchArticleHandler with ChangeNotifier {
  ArticleLoader articleLoader = ArticleLoader();
  List<EventPreviewData> eventArticleList = [];
  List<EventPreviewData> companionArticleList = [];
  ArticleType articleType = ArticleType.EVENT;
  bool loading = false;

  bool empty() {
    return eventArticleList.isEmpty && companionArticleList.isEmpty;
  }

  void searchArticles(String text) async {
    loading = true;
    eventArticleList =
        await articleLoader.loadSearchResults(text, ArticleType.EVENT);
    companionArticleList =
        await articleLoader.loadSearchResults(text, ArticleType.COMPANION);
    loading = false;
    notifyListeners();
  }
}
