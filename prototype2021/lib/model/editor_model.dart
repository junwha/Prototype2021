import 'package:flutter/cupertino.dart';

class EditorModel with ChangeNotifier {
  String title = "";
  String content = "";

  EditorModel() {}

  void printChanged() {
    print(title);
    print(content);
  }
}
