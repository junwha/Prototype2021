import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:prototype2021/model/map/location.dart';
import 'dart:convert';

import 'package:prototype2021/settings/constants.dart';

class EditorModel with ChangeNotifier {
  /* General Arguments */
  String title = "";
  String content = "";
  bool hasAge = false;
  bool hasGender = false;
  ArticleType articleType = ArticleType.EVENT;
  String recruitNumber = '0';
  String maleRecruitNumber = '0';
  String femaleRecruitNumber = '0';
  String startAge = '0';
  String endAge = '0';
  int uid = 0;
  DateTime? startDate;
  DateTime? endDate;

  WriteType writeType = WriteType.POST;

  /* For COMPANION */
  int? pid = 1; // TODO: Change to real pid

  /* For EVENT */
  int? cid;
  Location? location;

  /* For PATCH, PUT and TEMP */
  int? articleId;

  EditorModel();
  EditorModel.location(this.location);

  void printChanged() {}

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

    var url;
    if (this.articleType == ArticleType.COMPANION) {
      originData["pid"] = this.pid;
      url = Uri.parse(ENROLL_RECRUITMENTS_COMPANION_API);
    } else if (this.articleType == ArticleType.EVENT) {
      if (location == null) return false;
      originData["coord"] = {
        "lat": this.location!.latLng.latitude.toString().substring(0, 9),
        "long": this.location!.latLng.longitude.toString().substring(0, 9)
      };
      originData["cid"] = this.cid;
      url = Uri.parse(ENROLL_RECRUITMENTS_EVENT_API);
    }
    try {
      var response = await http.post(url,
          headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "X-CSRFToken":
                "ZrWI7Mf1KMz2WYJjQqo3H30l25UdY4bPcP3RthSlRMoUj7hGxz5Vp6fBWKS0n235"
          },
          body: jsonEncode(originData));
      print(response.body);
      if (response.statusCode == 201) return true;
    } catch (e) {
      print("Unexpected Error occurred");
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
