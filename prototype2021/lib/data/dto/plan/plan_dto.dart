import 'package:flutter/material.dart';
import 'package:prototype2021/data/location_data.dart';
import 'package:prototype2021/loader/article_loader.dart';
import 'package:prototype2021/loader/contents_loader.dart';
import 'package:prototype2021/model/contents_dto/content_preview.dart';

const Map<int, String> expenseCodeToString = {
  1: "10만원 미만",
  2: "10만원-30만원",
  3: "30만원-50만원",
  4: "50만원-100만원",
  5: "100만원 이상",
};

class PlanProps {
  final int id;
  final String title;
  final String area;
  final String? photo; // url
  final List<String> types;
  final String expense;
  final DateTimeRange period;

  PlanProps.fromJson({required Map<String, dynamic> json})
      : id = json["id"],
        title = json["title"],
        area = (json["area_code"] as List<dynamic>)
            .map((e) => areaCodeToAreaName[e])
            .toList()
            .join(", "),
        photo = json["photo"],
        types =
            (json["type"] as List<dynamic>).map((e) => e as String).toList(),
        expense = expenseCodeToString[json["expense"]] ?? "",
        period = DateTimeRange(
            start: DateTime.parse(json["start_date"]),
            end: DateTime.parse(json["end_date"]));
}

class PlanPreview extends PlanProps {
  final bool? hearted;
  PlanPreview.fromJson({required Map<String, dynamic> json})
      : hearted = json["hearted"],
        super.fromJson(json: json);
}

class PlanDetail extends PlanProps {
  final bool? hearted;
  final List<List<dynamic>> contents; // day -> cid and memo
  final UserData userData;

  //user
  PlanDetail.fromJson({required Map<String, dynamic> json})
      : hearted = json["hearted"],
        contents = (json["contents"] as List<dynamic>)
            .map((day) => (day as List<dynamic>)
                .map(
                  (entry) => entry["type"] == "C"
                      ? int.parse(entry["data"])
                      : entry["data"] as String,
                )
                .toList())
            .toList(),
        userData = UserData(json["user"]["id"], json["user"]["name"],
            null), // TODO: 유저 모델 수정 필요
        super.fromJson(json: json);
}