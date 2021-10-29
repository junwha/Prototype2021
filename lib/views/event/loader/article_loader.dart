import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:prototype2021/model/event/event_dto.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/utils/logger/logger.dart';

class ArticleLoader {
  Future<List<EventPreviewData>> loadSearchResults(
      String text, ArticleType articleType) async {
    String url;
    if (articleType == ArticleType.EVENT)
      url = "$apiBaseUrl/recruitments/events/search/?query=$text&page=1";
    else
      url = '$apiBaseUrl/recruitments/companions/search/?query=$text&page=1';

    try {
      http.Response response = await http.get(Uri.parse(url));
      Logger.logHTTP(response);
      return parseEventArticle(utf8.decode(response.bodyBytes));
    } catch (e) {
      Logger.errorWithInfo(e, "loader/article_loader.dart -> [Func Name]");
    }

    return [];
  }

  Future<List<EventTimerData>> loadTopEventArticles(
      ArticleType articleType) async {
    String url;
    if (articleType == ArticleType.EVENT)
      url = "$apiBaseUrl/recruitments/events/recommended/";
    else
      url = "$apiBaseUrl/recruitments/companions/recommended";
    // TOOD: modify this part with top companion api
    try {
      http.Response response = await http.get(Uri.parse(url));
      return parseTopEventArticle(
          utf8.decode(response.bodyBytes)); // 한글 깨짐 현상 해결 방법
    } catch (e) {
      Logger.errorWithInfo(e, "loader/article_loader.dart -> [Func Name]");
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
        Logger.errorWithInfo(e, "loader/article_loader.dart -> [Func Name]");
      }
    }
    return articleList;
  }

  Future<List<EventPreviewData>> loadEventArticles(
      ArticleType articleType) async {
    String url;
    if (articleType == ArticleType.EVENT) {
      url = "$apiBaseUrl/recruitments/events";
    } else {
      url = "$apiBaseUrl/recruitments/companions";
    }

    try {
      http.Response response = await http.get(Uri.parse(url));
      return parseEventArticle(
          utf8.decode(response.bodyBytes)); // 한글 깨짐 현상 해결 방법
    } catch (e) {
      Logger.errorWithInfo(e, "loader/article_loader.dart -> [Func Name]");
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
        Logger.errorWithInfo(e, "loader/article_loader.dart -> [Func Name]");
      }
    }
    return articleList;
  }

  Future<ArticleDetailData?> loadArticleDetail(
      int id, ArticleType articleType) async {
    String url;
    if (articleType == ArticleType.EVENT)
      url = "$apiBaseUrl/recruitments/events/$id";
    else
      url = "$apiBaseUrl/recruitments/companions/$id";
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
        Logger.errorWithInfo(e, "loader/article_loader.dart -> [Func Name]");
      }
    } catch (e) {
      Logger.errorWithInfo(e, "loader/article_loader.dart -> [Func Name]");
    }

    return null;
  }

  Future<bool> deleteArticle(int id, ArticleType articleType) async {
    String url;
    if (articleType == ArticleType.EVENT)
      url = "$apiBaseUrl/recruitments/events/$id/";
    else
      url = "$apiBaseUrl/recruitments/companions/$id/";
    try {
      http.Response response = await http.delete(Uri.parse(url));
      if (response.statusCode == 204) return true;
      Logger.logHTTP(response);
    } catch (e) {
      Logger.errorWithInfo(e, "loader/article_loader.dart -> [Func Name]");
    }
    return false;
  }
}
