import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/settings/constants.dart';

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
  int? placeId;
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
      this.placeId)
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
