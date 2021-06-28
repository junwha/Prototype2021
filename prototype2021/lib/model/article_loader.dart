import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArticleLoader {
  Future<List<EventArticleData>> loadTopEventArticles() async {
    String url =
        "http://api.tripbuilder.co.kr/recruitments/events/recommended/";
    try {
      http.Response response = await http.get(Uri.parse(url));
      return parseEventArticle(
          utf8.decode(response.bodyBytes)); // 한글 깨짐 현상 해결 방법
    } catch (e) {
      print("check internet");
    }

    return [];
  }

  List<EventArticleData> parseEventArticle(String jsonString) {
    dynamic jsonData = jsonDecode(jsonString);
    List<EventArticleData> articleList = [];

    for (Map<String, dynamic> data in jsonData) {
      try {
        print(data);

        articleList.add(EventArticleData(
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
}

class EventArticleData {
  int id;
  DateTimeRange period;
  String title;
  String summary;
  int? cid;

  EventArticleData(this.id, this.period, this.title, this.summary, this.cid);
}
