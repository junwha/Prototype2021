import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/loader/board/plan_loader.dart';
import 'package:prototype2021/loader/google_place/google_place_loader.dart';
import 'package:prototype2021/model/board/plan/plan_dto.dart';
import 'package:prototype2021/model/event/event_dto.dart';
import 'package:prototype2021/loader/event/article_loader.dart';
import 'package:prototype2021/model/google_place/place_data.dart';
import 'package:prototype2021/settings/constants.dart';

class EventArticleHandler with ChangeNotifier {
  ArticleLoader articleLoader = ArticleLoader();

  List<EventTimerData> topEventArticleList = [];
  List<EventPreviewData> eventArticleList = [];
  ArticleDetailData? detailData;

  ArticleType articleType = ArticleType.EVENT;
  LatLng? currentPosition;
  List<String>? images;

  bool isEventArticleLoading = false; // Loading flag of Article List
  bool isTopEventArticleLoading = false; // Loading flag of Top Article List

  GooglePlaceData? placeData;
  PlanDetail? planDetail;

  EventArticleHandler.main() {
    // TODO: automatically select current position

    loadTopArticles();
  }
  EventArticleHandler.detail({required this.articleType});

  void setArticleType(ArticleType articleType) {
    this.articleType = articleType;
    loadTopArticles();
    loadArticles();
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
    topEventArticleList =
        await articleLoader.loadTopEventArticles(this.articleType);

    isTopEventArticleLoading = false;
    notifyListeners();
  }

  void loadArticles() async {
    isEventArticleLoading = true;
    // TODO: add token
    eventArticleList = await articleLoader.loadEventArticles(this.articleType);
    isEventArticleLoading = false;
    notifyListeners();
  }

  Future<void> loadDetail(
      int id, ArticleType articleType, String? token) async {
    // TODO: add token
    this.detailData = null;
    this.placeData = null;
    this.planDetail = null;
    ArticleDetailData? result =
        await articleLoader.loadArticleDetail(id, articleType);
    if (result == null) {
      print("Article Load failed"); // TODO: move to exception page
      return;
    } else {
      detailData = result;
    }

    if (detailData is EventDetailData) {
      String? id = (detailData as EventDetailData).placeId;
      if (id != null) {
        PlaceLoader loader = PlaceLoader(center: LatLng(0, 0));
        this.placeData = await loader.getDataById(id);
      }
    } else if (detailData is CompanionDetailData) {
      int? id = (detailData as CompanionDetailData).pid;
      if (id != null) {
        PlanLoader loader = PlanLoader();
        this.planDetail = await loader.getPlanDetail(id: id, token: token);
      }
    }

    notifyListeners();
  }

  Future<bool> deleteArticle(int id, ArticleType articleType) async {
    bool isDelete = await articleLoader.deleteArticle(id, articleType);
    if (isDelete) {
      loadTopArticles();
      loadArticles();
      notifyListeners();
    }
    return isDelete;
  }
}
