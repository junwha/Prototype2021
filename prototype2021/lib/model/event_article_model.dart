import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/model/article_loader.dart';
import 'package:prototype2021/settings/constants.dart';

class EventArticleModel with ChangeNotifier {
  ArticleLoader articleLoader = ArticleLoader();

  List<EventTimerData> topEventArticleList = [];
  List<EventPreviewData> eventArticleList = [];
  ArticleDetailData? detailData;

  ArticleType articleType = ArticleType.EVENT;
  LatLng? currentPosition;
  List<String>? images;

  bool isEventArticleLoading = false; // Loading flag of Article List
  bool isTopEventArticleLoading = false; // Loading flag of Top Article List

  EventArticleModel() {
    loadArticles();
  }

  EventArticleModel.eventDetail(int id) {
    loadDetail(id, ArticleType.EVENT);
    this.articleType = ArticleType.EVENT;
  }

  EventArticleModel.companionDetail(int id) {
    loadDetail(id, ArticleType.COMPANION);
    this.articleType = ArticleType.COMPANION;
  }

  EventArticleModel.main() {
    // TODO: automatically select current position

    loadTopArticles();
  }

  void loadImages() async {
    this.images = [
      'https://t3.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/2fG8/image/InuHfwbrkTv4FQQiaM7NUvrbi8k.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Hong_Kong_Night_view.jpg/450px-Hong_Kong_Night_view.jpg'
    ]; // TODO: load image from server
    notifyListeners();
  }

  void loadTopArticles() async {
    isTopEventArticleLoading = true;
    topEventArticleList = await articleLoader.loadTopEventArticles();
    isTopEventArticleLoading = false;
    notifyListeners();
  }

  void loadArticles() async {
    isEventArticleLoading = true;
    // TODO: add token
    eventArticleList = await articleLoader.loadEventArticles();
    isEventArticleLoading = false;
    notifyListeners();
  }

  void loadDetail(int id, ArticleType articleType) async {
    // TODO: add token

    if (articleType == ArticleType.EVENT) {
      ArticleDetailData? result =
          await articleLoader.loadArticleDetail(id, articleType);
      if (result == null) {
        print("Article Load failed"); // TODO: move to exception page
        return;
      } else {
        detailData = result;
      }
    }
    notifyListeners();
  }
}
