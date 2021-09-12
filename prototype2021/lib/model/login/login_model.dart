import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginModel with ChangeNotifier {
  String id = "";
  String password = "";
  bool loginChecked = false;
  bool idChecked = false;

  LoginModel();
}
