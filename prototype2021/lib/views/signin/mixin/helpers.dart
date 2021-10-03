import 'package:flutter/material.dart';
import 'package:prototype2021/handler/signin/signin_model.dart';
import 'package:provider/provider.dart';

mixin SigninViewHelper {
  void navigateToNext(BuildContext context,
      {required SignInModel model, required Widget child}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
                create: (_) => model.inherit(),
                child: child,
              )),
    );
  }

  String generateErrorText(error) =>
      "예기치 못한 에러가 발생했습니다: ${error.toString().substring(0, 30)}...";
}
