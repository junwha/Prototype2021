import 'package:flutter/material.dart';
import 'package:prototype2021/loader/signin/signin_loader.dart';
import 'package:prototype2021/handler/signin/signin_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/widgets/dialogs/pop_up.dart';
import 'package:prototype2021/views/signin/mixin/helpers.dart';
import 'package:prototype2021/views/signin/mixin/widgets.dart';
import 'package:prototype2021/views/login/login_view.dart';

import 'package:prototype2021/views/signin/signin_term_view.dart';
import 'package:provider/provider.dart';

class SigninView extends StatefulWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  _SigninViewState createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView>
    with SigninLoader, SignInViewWidgets, SigninViewHelper {
  String username = "";
  String password = "";
  String passwordConfirm = "";
  bool invalidUsername = false;
  bool invalidPassword = false;
  bool invalidPasswordConfirm = false;
  bool hasDuplicate = false;
  bool checkedDuplicate = false;
  bool loading = false;

  void setId(String id) => setState(() {
        username = id;
      });
  void setPassword(String pw) => setState(() {
        password = pw;
      });
  void setPasswordConfirm(String pwConfirm) => setState(() {
        passwordConfirm = pwConfirm;
      });
  void setLoading(bool isLoading) => setState(() {
        loading = isLoading;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, shouldPopTo: LoginView, title: "회원가입"),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0 * pt, 36 * pt, 20 * pt, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSignInInput(context,
                hintText: "사용할 아이디를 입력해주세요.",
                onTextChange: setId,
                onError: invalidUsername,
                hasActionButton: true,
                onActionButtonPressed: checkDuplicacy,
                actionButtonText: "중복\n확인",
                underText: '영문, 숫자 조합으로 6자 이상',
                showUnderText: true),
            SizedBox(
              height: 16,
            ),
            buildSignInInput(
              context,
              hintText: "비밀번호를 입력해주세요.",
              onTextChange: setPassword,
              onError: invalidPassword,
              underText: '영문, 숫자 특수 문자 조합으로 8자 이상',
              showUnderText: true,
              isPasswordField: true,
            ),
            SizedBox(
              height: 16,
            ),
            buildSignInInput(context,
                hintText: "비밀번호를 다시 입력해주세요.",
                onTextChange: setPasswordConfirm,
                onError: invalidPasswordConfirm,
                underText: '비밀번호가 일치하지 않습니다.',
                isPasswordField: true),
            SizedBox(
              height: 40,
            ),
            buildNextButton(context),
          ],
        ),
      ),
    );
  }

  TextButton buildNextButton(BuildContext context) {
    SignInModel signinModel = Provider.of<SignInModel>(context);
    void onPressed() {
      bool isValid = validate();
      if (isValid) {
        signinModel.setCredentials(username, password);
        navigateToNext(context, model: signinModel, child: SigninTermView());
      }
    }

    return buildSigninButton(context, onPressed: onPressed, text: "화원가입");
  }

  Future<void> checkDuplicacy() async {
    setLoading(true);
    try {
      bool _hasDuplicate = await checkIfIdHasDuplicate(username);
      if (_hasDuplicate) {
        tbShowTextDialog(context, "ID가 중복되어 사용할 수 없습니다");
      } else {
        tbShowTextDialog(context, "사용할 수 있는 아이디입니다");
      }
      setState(() {
        hasDuplicate = _hasDuplicate;
        checkedDuplicate = true;
      });
    } catch (error) {
      tbShowTextDialog(context, generateErrorText(error));
    }
    setLoading(false);
  }

  bool validate() {
    RegExp numericExp = RegExp(r'[0-9]+');
    RegExp alphabetExp = RegExp(r'[a-zA-Z]');
    RegExp specialCharExp = RegExp(r'[^a-zA-Z0-9]');
    if (!checkedDuplicate) {
      tbShowTextDialog(context, "ID 중복 확인을 해주세요");
      return false;
    }
    if (numericExp.hasMatch(username) &&
        alphabetExp.hasMatch(username) &&
        username.length >= 6) {
      setState(() {
        invalidUsername = false;
      });
    } else {
      setState(() {
        invalidUsername = true;
      });
    }
    if (numericExp.hasMatch(password) &&
        alphabetExp.hasMatch(password) &&
        specialCharExp.hasMatch(password) &&
        password.length >= 8) {
      setState(() {
        invalidPassword = false;
      });
    } else {
      setState(() {
        invalidPassword = true;
      });
    }
    if (password == passwordConfirm) {
      setState(() {
        invalidPasswordConfirm = false;
      });
    } else {
      setState(() {
        invalidPasswordConfirm = true;
      });
    }
    if (!invalidUsername && !invalidPassword && !invalidPasswordConfirm) {
      return true; // valid form submission
    }
    if (hasDuplicate) {
      tbShowTextDialog(context, "중복되지 않는 ID로 변경해주세요");
    }
    return false; // not valid form submission
  }
}
