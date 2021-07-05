import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype2021/model/article_loader.dart';
import 'package:prototype2021/model/map/location.dart';
import 'package:prototype2021/model/map/map_place.dart';
import 'package:prototype2021/model/safe_http.dart';

import 'package:prototype2021/settings/constants.dart';

class EditorModel with ChangeNotifier {
  /* General Arguments */
  String title = "";
  String content = "";
  bool hasAge = false;
  bool hasGender = false;
  String recruitNumber = '0';
  String maleRecruitNumber = '0';
  String femaleRecruitNumber = '0';
  String startAge = '0';
  String endAge = '0';
  int uid = 0;
  DateTime? startDate;
  DateTime? endDate;

  WriteType writeType = WriteType.POST;
  ArticleType articleType = ArticleType.EVENT;

  /* For COMPANION */
  int? pid = 1; // TODO: Change to real pid

  /* For EVENT */
  int? cid;
  Location? location;

  /* For PATCH, PUT and TEMP */
  int? articleId;

  EditorModel();
  EditorModel.location(this.location);
  EditorModel.editEvent(EventDetailData data) {
    this.writeType = WriteType.PUT;
    initData(data);
    this.cid = data.cid;
    this.location =
        Location(data.coord, PlaceType.DEFAULT, ""); // TODO: modify this part
  }

  EditorModel.editCompanion(CompanionDetailData data) {
    this.writeType = WriteType.PUT;
    this.pid = data.pid;
    initData(data);
  }

  void initData(ArticleDetailData data) {
    this.title = data.title;
    this.content = data.body;
    if (data.male == -1 || data.female == -1) {
      this.hasAge = false;
    }
    this.startAge = data.minAge.toString();
    this.endAge = data.maxAge.toString();
    if (data.female == -1 || data.male == -1) {
      this.hasGender = false;
    }
    this.recruitNumber = data.recruit.toString();
    this.maleRecruitNumber = data.male.toString();
    this.femaleRecruitNumber = data.female.toString();
    this.uid = data.userData.uid;
    this.startDate = data.period.start;
    this.endDate = data.period.end;
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
      "uid": 1,
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
    if (this.articleType == ArticleType.COMPANION) {
      return await writeCompanionArticle(originData);
    } else if (this.articleType == ArticleType.EVENT) {
      return await writeEventArticle(originData);
    }

    return false;
  }

  Future<bool> writeCompanionArticle(Map<String, dynamic> originData) async {
    originData["pid"] = this.pid;
    var url;

    if (this.writeType == WriteType.POST) {
      url = POST_RECRUITMENTS_COMPANION_API;
      return await safePOST(url, originData);
    } else if (this.writeType == WriteType.PUT) {
      if (articleId == null) return false;
      url =
          "http://api.tripbuilder.co.kr/recruitments/companions/${articleId!}/";
      return await safePUT(url, originData);
    }
    return false;
  }

  Future<bool> writeEventArticle(Map<String, dynamic> originData) async {
    if (location == null) return false;
    originData["coord"] = {
      "lat": this.location!.latLng.latitude.toString().substring(0, 9),
      "long": this.location!.latLng.longitude.toString().substring(0, 9)
    };

    originData["cid"] = this.cid;

    var url;

    if (this.writeType == WriteType.POST) {
      url = POST_RECRUITMENTS_EVENT_API;
      return await safePOST(url, originData);
    } else if (this.writeType == WriteType.PUT) {
      if (articleId == null) return false;
      url = "http://api.tripbuilder.co.kr/recruitments/events/${articleId!}/";
      return await safePUT(url, originData);
    }
    return false;
  }
}

enum WriteType {
  POST,
  PUT,
  PATCH,
  TEMP,
}
