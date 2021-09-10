import 'package:flutter/material.dart';
import 'package:prototype2021/model/signin_model.dart';
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
}
