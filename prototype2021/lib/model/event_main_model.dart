import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/settings/constants.dart';

class EventMainModel with ChangeNotifier {
  ArticleType articleType = ArticleType.EVENT;
  LatLng? currentPosition;
  List<String> images = [
    'https://t3.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/2fG8/image/InuHfwbrkTv4FQQiaM7NUvrbi8k.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Hong_Kong_Night_view.jpg/450px-Hong_Kong_Night_view.jpg'
  ];
  List<Map<String, dynamic>>? eventArticles; // TODO: Define data models
  List<Map<String, dynamic>>? companionArticles;

  EventMainModel() {
    // TODO: automatically select current position
  }

  void loadImages() async {}

  void loadArticles() async {}
}
