import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        print(data);

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
    String url = "http://api.tripbuilder.co.kr/recruitments/events/";
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
    dynamic jsonData = jsonDecode(jsonString);
    List<EventPreviewData> articleList = [];

    for (Map<String, dynamic> data in jsonData) {
      try {
        print(data);

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
