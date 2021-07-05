import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/article_loader.dart';
import 'package:prototype2021/settings/constants.dart';

class SearchArticleModel with ChangeNotifier {
  ArticleLoader articleLoader = ArticleLoader();
  List<EventPreviewData> articleList = [];
  ArticleType articleType = ArticleType.EVENT;
  bool loading = false;

  void searchArticles(String text) async {
    loading = true;
    articleList = await articleLoader.loadSearchResults(text, articleType);
    loading = false;
    notifyListeners();
  }
}
