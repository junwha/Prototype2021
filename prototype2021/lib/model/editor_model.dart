import 'package:flutter/cupertino.dart';

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
}
