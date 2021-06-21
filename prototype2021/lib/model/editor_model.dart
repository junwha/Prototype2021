import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const COMPANION = false;
const EVENT = true;

class EditorModel with ChangeNotifier {
  String title = "";
  String content = "";
  bool hasAge = false;
  bool hasGender = false;
  bool articleType = EVENT;
  String recruitNumber = '0';
  String maleRecruitNumber = '0';
  String femaleRecruitNumber = '0';
  String startAge = '0';
  String endAge = '0';

  EditorModel() {}

  void printChanged() {
    print(title);
    print(content);
    print(hasAge);
    print(hasGender);
    print(recruitNumber);
    print(maleRecruitNumber);
    print(femaleRecruitNumber);
    print(startAge);
    print(endAge);
  }

  void writeArticle() async {
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
        "start": "2021-05-23T09:22:23.150Z",
        "end": "2021-05-23T09:22:23.150Z"
      },
      "pid": 1
    };
    var url = Uri.parse(
        'http://ec2-13-125-99-249.ap-northeast-2.compute.amazonaws.com/recruitments/companions/');
    var response = await http.post(url,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "X-CSRFToken":
              "ZrWI7Mf1KMz2WYJjQqo3H30l25UdY4bPcP3RthSlRMoUj7hGxz5Vp6fBWKS0n235"
        },
        body: jsonEncode(originData));
    print(response.statusCode);
    print(response.body);
  }
}
