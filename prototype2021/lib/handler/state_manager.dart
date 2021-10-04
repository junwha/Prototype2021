import 'package:flutter/material.dart';

class StateManager with ChangeNotifier {
  void setState(void Function() callback) {
    callback();
    notifyListeners();
  }
}
