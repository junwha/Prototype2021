import 'package:flutter/material.dart';
import 'package:prototype2021/model/event/event_dto.dart';
import 'package:prototype2021/data/location_data.dart';
import 'package:prototype2021/model/board/place_data_props.dart';
import 'package:prototype2021/utils/safe_http/common.dart';

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
  final List<int> areaCodes;
  final String? photo; // url
  final List<String> types;
  final int expense;
  final DateTimeRange period;
  final int expenseStyle;
  final int fatigueStyle;

  PlanProps(
    this.id,
    this.title,
    this.areaCodes,
    this.photo,
    this.types,
    this.expense,
    this.period,
    this.expenseStyle,
    this.fatigueStyle,
  );

  PlanProps.fromJson({required Map<String, dynamic> json})
      : id = json["id"],
        title = json["title"],
        areaCodes = dynamicListToTList<int>(json["area_code"]),
        photo = nullable<String>(json["photo"]),
        types = dynamicListToTList<String>(json["type"]),
        expense = json["expense"],
        expenseStyle = json["expense_style"],
        fatigueStyle = json["fatigue_style"],
        period = DateTimeRange(
            start: DateTime.parse(json["start_date"]),
            end: DateTime.parse(json["end_date"]));

  String get areaText =>
      areaCodes.map((code) => areaCodeToAreaName[code]).join(", ");
  String get expenseText => expenseCodeToString[expense] ?? "";
}

class PlanPreview extends PlanProps {
  final bool? hearted;
  PlanPreview.fromJson({required Map<String, dynamic> json})
      : hearted = nullable<bool>(json["hearted"]),
        super.fromJson(json: json);
}

class PlanDetail extends PlanProps {
  final bool? hearted;
  final List<List<dynamic>> contents; // day -> cid and memo
  final UserData userData;

  //user
  PlanDetail.fromJson({required Map<String, dynamic> json})
      : hearted = nullable<bool>(json["hearted"]),
        contents = dynamicListToTList<List<dynamic>>(json["contents"])
            .map((day) => (day)
                .map(
                  (entry) => entry["type"] == "C"
                      ? int.parse(entry["data"])
                      : entry["data"] as String,
                )
                .toList())
            .toList(),
        userData = UserData(json["user"]["id"], json["user"]["name"],
            nullable<String>(json["user"]["photo"])), 
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
    int expenseStyle,
    int fatigueStyle,
    this.contents,
  ) : super(id, title, areaCode, photo, types, expense, period, expenseStyle,
            fatigueStyle);
}
