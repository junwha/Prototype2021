import 'package:flutter/material.dart';

class SignInModel with ChangeNotifier {
  String _username = "";
  String _password = "";

  String get username => _username;
  String get password => _password;

  void setCredentials(String username, String password) {
    _username = username;
    _password = password;
    notifyListeners();
  }

  /* 
   * This method is just for readability purpose
   * Use this when you need to pass the change notifier model
   * to next page route
  */
  SignInModel inherit() => this;
}
