import 'package:flutter/material.dart';
import 'package:prototype2021/data/event_dto.dart';
import 'package:prototype2021/data/location_data.dart';
import 'package:prototype2021/data/place_data_props.dart';

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
  final List<int> area;
  final String? photo; // url
  final List<String> types;
  final int expense;
  final DateTimeRange period;
  final int expense_style;
  final int fatigue_style;

  PlanProps(
    this.id,
    this.title,
    this.area,
    this.photo,
    this.types,
    this.expense,
    this.period,
    this.expense_style,
    this.fatigue_style,
  );

  PlanProps.fromJson({required Map<String, dynamic> json})
      : id = json["id"],
        title = json["title"],
        area =
            (json["area_code"] as List<dynamic>).map((e) => e as int).toList(),
        photo = json["photo"],
        types =
            (json["type"] as List<dynamic>).map((e) => e as String).toList(),
        expense = json["expense"],
        expense_style = json["expense_style"],
        fatigue_style = json["fatigue_style"],
        period = DateTimeRange(
            start: DateTime.parse(json["start_date"]),
            end: DateTime.parse(json["end_date"]));

  String get areaText => area.map((e) => areaCodeToAreaName[e]).join(", ");
  String get expenseText => expenseCodeToString[expense] ?? "";
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

class PlanData extends PlanProps {
  final List<List<PlaceDataProps>> contents; // day -> cid and memo

  PlanData(
    int id,
    String title,
    List<int> areaCode,
    String? photo,
    List<String> types,
    int expense,
    DateTimeRange period,
    int expense_style,
    int fatigue_style,
    this.contents,
  ) : super(id, title, areaCode, photo, types, expense, period, expense_style,
            fatigue_style);
}
