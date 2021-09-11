import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:prototype2021/settings/constants.dart';

class ArticleLoader {
  Future<List<EventPreviewData>> loadSearchResults(
      String text, ArticleType articleType) async {
    String url;
    if (articleType == ArticleType.EVENT)
      url =
          "http://api.tripbuilder.co.kr/recruitments/events/search/?query=$text&page=1";
    else
      url =
          'http://api.tripbuilder.co.kr/recruitments/companions/search/?query=$text&page=1';

    try {
      http.Response response = await http.get(Uri.parse(url));
      print(response.body);
      return parseEventArticle(utf8.decode(response.bodyBytes));
    } catch (e) {
      print(e);
      print("check internet");
    }

    return [];
  }

  Future<List<EventTimerData>> loadTopEventArticles(
      ArticleType articleType) async {
    String url;
    if (articleType == ArticleType.EVENT)
      url = "http://api.tripbuilder.co.kr/recruitments/events/recommended/";
    else
      url = "http://api.tripbuilder.co.kr/recruitments/companions/recommended";
    // TOOD: modify this part with top companion api
    try {
      http.Response response = await http.get(Uri.parse(url));
      return parseTopEventArticle(
          utf8.decode(response.bodyBytes)); // 한글 깨짐 현상 해결 방법
    } catch (e) {
      print(e);
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

  Future<List<EventPreviewData>> loadEventArticles(
      ArticleType articleType) async {
    String url;
    if (articleType == ArticleType.EVENT) {
      url = "http://api.tripbuilder.co.kr/recruitments/events";
    } else {
      url = "http://api.tripbuilder.co.kr/recruitments/companions";
    }

    try {
      http.Response response = await http.get(Uri.parse(url));
      return parseEventArticle(
          utf8.decode(response.bodyBytes)); // 한글 깨짐 현상 해결 방법
    } catch (e) {
      print(e);
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

  Future<ArticleDetailData?> loadArticleDetail(
      int id, ArticleType articleType) async {
    String url;
    if (articleType == ArticleType.EVENT)
      url = "http://api.tripbuilder.co.kr/recruitments/events/$id";
    else
      url = "http://api.tripbuilder.co.kr/recruitments/companions/$id";
    try {
      http.Response response = await http.get(Uri.parse(url));

      Map<String, dynamic> data =
          jsonDecode(utf8.decode(response.bodyBytes)); // 한글 깨짐 현상 해결 방법
      try {
        if (articleType == ArticleType.EVENT)
          return EventDetailData(
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
        else
          return CompanionDetailData(
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
            data["pid"],
          );
      } catch (e) {
        print(e);
        print("error occurred");
      }
    } catch (e) {
      print("check internet");
      print(e);
    }

    return null;
  }

  Future<bool> deleteArticle(int id, ArticleType articleType) async {
    String url;
    if (articleType == ArticleType.EVENT)
      url = "http://api.tripbuilder.co.kr/recruitments/events/${id}/";
    else
      url = "http://api.tripbuilder.co.kr/recruitments/companions/${id}/";
    try {
      http.Response response = await http.delete(Uri.parse(url));
      if (response.statusCode == 204) return true;
      print(response.body);
    } catch (e) {
      print(e);
      print("check internet");
    }
    return false;
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

class UserData {
  String nickname;
  late String photo;
  int uid;
  UserData(this.uid, this.nickname, String? profilePhoto) {
    this.photo = profilePhoto ?? placeHolder;
  }
}

class ArticleDetailData {
  int id;
  UserData userData;
  int hearts;
  String title;
  String body;
  int recruit;
  int male;
  int female;
  int minAge;
  int maxAge;

  DateTimeRange period;

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
  );
}

class EventDetailData extends ArticleDetailData {
  int? cid;
  LatLng coord;
  EventDetailData(
      int id,
      UserData userData,
      int hearts,
      String title,
      String body,
      int recruit,
      int male,
      int female,
      int minAge,
      int maxAge,
      DateTimeRange period,
      this.coord,
      this.cid)
      : super(id, userData, hearts, title, body, recruit, male, female, minAge,
            maxAge, period);
}

class CompanionDetailData extends ArticleDetailData {
  int? pid;

  CompanionDetailData(
      int id,
      UserData userData,
      int hearts,
      String title,
      String body,
      int recruit,
      int male,
      int female,
      int minAge,
      int maxAge,
      DateTimeRange period,
      this.pid)
      : super(id, userData, hearts, title, body, recruit, male, female, minAge,
            maxAge, period);
}
