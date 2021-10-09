import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype2021/handler/login/login_handler.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/model/event/event_dto.dart';
import 'package:prototype2021/utils/google_map/handler/location.dart';
import 'package:prototype2021/loader/google_place/google_place_loader.dart';
import 'package:prototype2021/utils/safe_http/base.dart';
import 'package:prototype2021/utils/safe_http/legacy_http.dart';

import 'package:prototype2021/settings/constants.dart';
import 'package:provider/provider.dart';

class EditorHandler with ChangeNotifier {
  /* General Arguments */
  String title = "";
  String content = "";
  bool hasAge = true;
  bool hasGender = true;
  int recruitNumber = 0;
  int maleRecruitNumber = 0;
  int femaleRecruitNumber = 0;
  int startAge = 0;
  int endAge = 0;
  int uid = 0;
  DateTime? startDate;
  DateTime? endDate;

  WriteType writeType = WriteType.POST;
  ArticleType articleType = ArticleType.EVENT;

  /* For COMPANION */
  int? pid = 1; // TODO: Change to real pid

  /* For EVENT */
  int? placeId;
  Location? location;

  /* For PATCH, PUT and TEMP */
  int? articleId;

  UserInfoHandler userInfoHandler;

  EditorHandler({this.location, required this.userInfoHandler});

  EditorHandler.edit(
      {required ArticleDetailData data, required this.userInfoHandler}) {
    this.articleId = data.id;
    this.writeType = WriteType.EDIT;

    this.title = data.title;
    this.content = data.body;
    if (data.minAge == -1 || data.maxAge == -1) {
      this.hasAge = false;
    } else {
      this.startAge = data.minAge;
      this.endAge = data.maxAge;
    }
    if (data.female == -1 || data.male == -1) {
      this.hasGender = false;
      this.recruitNumber = data.recruit;
    } else {
      this.maleRecruitNumber = data.male;
      this.femaleRecruitNumber = data.female;
    }

    this.startDate = data.period.start;
    this.endDate = data.period.end;

    if (data is EventDetailData)
      initEvent(data);
    else if (data is CompanionDetailData) initCompanion(data);
  }

  void initEvent(EventDetailData data) {
    this.articleType = ArticleType.EVENT;
    this.writeType = WriteType.EDIT;
    this.placeId = data.placeId;
    this.location =
        Location(data.coord, PlaceType.DEFAULT, ""); // TODO: modify this part
  }

  void initCompanion(CompanionDetailData data) {
    this.articleType = ArticleType.COMPANION;
    this.pid = data.pid;
  }

  void setStartDate(DateTime? startDate) {
    this.startDate = startDate;
    notifyListeners();
  }

  void setEndDate(DateTime? endDate) {
    this.endDate = endDate;
    notifyListeners();
  }

  Future<bool> writeArticle() async {
    Map<String, dynamic> originData = {
      "uid": userInfoHandler.userId,
      "title": this.title,
      "body": this.content,
      "recruits": {
        "no": this.recruitNumber,
        "male": this.maleRecruitNumber,
        "female": this.femaleRecruitNumber
      },
      "ages": {"min": this.startAge, "max": this.endAge},
      "period": {
        "start":
            this.startDate == null ? null : this.startDate!.toIso8601String(),
        "end": this.endDate == null ? null : this.endDate!.toIso8601String()
      },
    };

    if (!this.hasGender) {
      originData["recruits"]["male"] = -1;
      originData["recruits"]["female"] = -1;
    } else {
      originData["recruits"]["no"] = -1;
    }

    if (!this.hasAge) {
      originData["ages"]["min"] = -1;
      originData["ages"]["max"] = -1;
    }

    if (this.articleType == ArticleType.COMPANION) {
      return await writeCompanionArticle(originData);
    } else if (this.articleType == ArticleType.EVENT) {
      return await writeEventArticle(originData);
    }

    return false;
  }

  Map<String, String> getHeaders() {
    Map<String, String> newHeaders = {};
    defaultHeaders.entries.forEach((element) {
      newHeaders[element.key] = element.value;
    });
    newHeaders['Authorization'] = 'jwt ${userInfoHandler.token}';
    return newHeaders;
  }

  Future<bool> writeCompanionArticle(Map<String, dynamic> originData) async {
    originData["pid"] = this.pid;
    var url;
    if (this.writeType == WriteType.POST) {
      url = POST_RECRUITMENTS_COMPANION_API;
      return await legacyPOST(url, originData, headers: getHeaders());
    } else if (this.writeType == WriteType.EDIT) {
      if (articleId == null) return false;
      url =
          "http://api.tripbuilder.co.kr/recruitments/companions/${articleId!}/";
      return await legacyPUT(url, originData, headers: getHeaders());
    }
    return false;
  }

  Future<bool> writeEventArticle(Map<String, dynamic> originData) async {
    if (location == null) return false;
    originData["coord"] = {
      "lat": this.location!.latLng.latitude.toStringAsFixed(6),
      "long": this.location!.latLng.longitude.toStringAsFixed(6),
    };

    originData["place_id"] = this.placeId;

    var url;

    if (this.writeType == WriteType.POST) {
      url = POST_RECRUITMENTS_EVENT_API;
      return await legacyPOST(url, originData, headers: getHeaders());
    } else if (this.writeType == WriteType.EDIT) {
      if (articleId == null) return false;
      url = "http://api.tripbuilder.co.kr/recruitments/events/${articleId!}/";
      return await legacyPUT(url, originData, headers: getHeaders());
    }
    return false;
  }
}

enum WriteType { POST, EDIT, LOCATION_POST }
