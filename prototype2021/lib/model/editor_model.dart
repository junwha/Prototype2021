import 'package:flutter/cupertino.dart';

class EditorModel with ChangeNotifier {
  String title = "";
  String content = "";
  bool hasAge = false;
  bool hasGender = false;

  EditorModel() {}

  void printChanged() {
    print(title);
    print(content);
    print(hasAge);
    print(hasGender);
  }
}
