import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:prototype2021/settings/constants.dart';

class ArticleLoader {
  Future<List<EventTimerData>> loadTopEventArticles() async {
    String url =
        "http://api.tripbuilder.co.kr/recruitments/events/recommended/";
    try {
      http.Response response = await http.get(Uri.parse(url));
      return parseTopEventArticle(
          utf8.decode(response.bodyBytes)); // 한글 깨짐 현상 해결 방법
    } catch (e) {
      print("check internet");
    }

    return [];
  }

  List<EventTimerData> parseTopEventArticle(String jsonString) {
    dynamic jsonData = jsonDecode(jsonString);
    List<EventTimerData> articleList = [];

    for (Map<String, dynamic> data in jsonData) {
      try {
        articleList.add(EventTimerData(
          data["id"],
          DateTimeRange(
            start: DateTime.parse(data["period"]["start"] ?? ""),
            end: DateTime.parse(data["period"]["end"] ?? ""),
          ),
          data["title"],
          data["summary"],
          data["cid"],
        ));
      } catch (e) {
        print(e);
        print("error occurred");
      }
    }
    return articleList;
  }

  Future<List<EventPreviewData>> loadEventArticles() async {
    String url = "http://api.tripbuilder.co.kr/recruitments/events";
    try {
      http.Response response = await http.get(Uri.parse(url));
      return parseEventArticle(
          utf8.decode(response.bodyBytes)); // 한글 깨짐 현상 해결 방법
    } catch (e) {
      print("check internet");
    }

    return [];
  }

  List<EventPreviewData> parseEventArticle(String jsonString) {
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    List<EventPreviewData> articleList = [];

    for (Map<String, dynamic> data in jsonData["results"]) {
      try {
        articleList.add(EventPreviewData(
          data["id"],
          data["title"],
          data["hearts"],
          data["comments"],
          DateTimeRange(
            start: DateTime.parse(data["period"]["start"] ?? ""),
            end: DateTime.parse(data["period"]["end"] ?? ""),
          ),
        ));
      } catch (e) {
        print(e);
        print("error occurred");
      }
    }
    return articleList;
  }

  Future<ArticleDetailData?> loadArticleDetail(int id) async {
    String url = "http://api.tripbuilder.co.kr/recruitments/events/$id";
    try {
      http.Response response = await http.get(Uri.parse(url));

      Map<String, dynamic> data =
          jsonDecode(utf8.decode(response.bodyBytes)); // 한글 깨짐 현상 해결 방법
      try {
        return ArticleDetailData(
            data["id"],
            UserData(data["user_data"]["uid"], data["user_data"]["nickname"],
                data["user_data"]["profile_photo"]),
            data["hearts"],
            data["title"],
            data["body"],
            data["recruits"]["no"],
            data["recruits"]["male"],
            data["recruits"]["female"],
            data["ages"]["min"],
            data["ages"]["max"],
            DateTimeRange(
              start: DateTime.parse(data["period"]["start"] ?? ""),
              end: DateTime.parse(data["period"]["end"] ?? ""),
            ),
            LatLng(double.parse(data["coord"]["lat"]),
                double.parse(data["coord"]["long"])),
            data["cid"]);
      } catch (e) {
        print(e);
        print("error occurred");
      }
    } catch (e) {
      print("check internet");
    }

    return null;
  }
}

class EventTimerData {
  int id;
  DateTimeRange period;
  String title;
  String summary;
  int? cid;

  EventTimerData(this.id, this.period, this.title, this.summary, this.cid);
}

class EventPreviewData {
  int id;
  String title;
  int hearts;
  int comments;
  DateTimeRange period;

  EventPreviewData(
      this.id, this.title, this.hearts, this.comments, this.period);
}

class ArticleDetailData {
  String title;
  String body;
  UserData userData;
  int recruit;
  int male;
  int female;
  int minAge;
  int maxAge;
  int hearts;
  DateTimeRange period;
  int id;
  int? cid;
  LatLng coord;

  ArticleDetailData(
      this.id,
      this.userData,
      this.hearts,
      this.title,
      this.body,
      this.recruit,
      this.male,
      this.female,
      this.minAge,
      this.maxAge,
      this.period,
      this.coord,
      this.cid) {}
}

class UserData {
  String nickname;
  late String photo;
  int uid;
  UserData(this.uid, this.nickname, String? profilePhoto) {
    this.photo = profilePhoto ?? placeHolder;
  }
}
