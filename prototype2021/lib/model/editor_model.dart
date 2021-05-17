import 'package:flutter/cupertino.dart';

const COMPANION = false;
const EVENT = true;

class EditorModel with ChangeNotifier {
  String title = "";
  String content = "";
  bool hasAge = false;
  bool hasGender = false;
  bool articleType = EVENT;
  EditorModel() {}

  void printChanged() {
    print(title);
    print(content);
    print(hasAge);
    print(hasGender);
  }
}
