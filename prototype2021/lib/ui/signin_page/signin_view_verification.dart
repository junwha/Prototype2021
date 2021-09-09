import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prototype2021/loader/signin_loader.dart';
import 'package:prototype2021/model/signin_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/pop_up.dart';
import 'package:prototype2021/theme/signin/widgets.dart';
import 'package:prototype2021/ui/signin_page/signin_term_view.dart';
import 'package:provider/provider.dart';

class SignInViewVerification extends StatefulWidget {
  const SignInViewVerification({Key? key}) : super(key: key);

  @override
  _SignInViewVerificationState createState() => _SignInViewVerificationState();
}

class _SignInViewVerificationState extends State<SignInViewVerification>
    with SignInViewWidgets, SigninLoader {
  Timer? timer;
  int remain = 60 * 5;

  void startTimer() {
    setState(() {
      remain = 60 * 5;
    });
    const aSec = const Duration(seconds: 1);
    timer = new Timer.periodic(aSec, (timer) {
      if (remain == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          remain--;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  bool codeSended = false;
  String credential = "";
  int verificationCode = 0;
  String verificationToken = "";
  void setCodeSended(bool _codeSended) => setState(() {
        codeSended = _codeSended;
      });
  void setCredential(String _credential) => setState(() {
        credential = _credential;
      });
  void setVerificationCode(String _verificationCode) => setState(() {
        verificationCode = _verificationCode as int;
      });
  void setVerificationToken(String _verificationToken) => setState(() {
        verificationToken = _verificationToken;
      });

  Future<void> Function() requestVerificationFactory(
          VerificationMethod method) =>
      () async {
        try {
          String _verificationToken = await requestAuth(credential, method);
          setVerificationToken(_verificationToken);
          startTimer();
        } catch (error) {
          tbShowTextDialog(context,
              "예기치 못한 에러가 발생했습니다: ${error.toString().substring(0, 30)}...");
        }
      };

  @override
  Widget build(BuildContext context) {
    SignInModel signInModel = Provider.of<SignInModel>(context);
    String modeToString =
        signInModel.method == VerificationMethod.Email ? "이메일을" : "전화번호를";
    return Scaffold(
        appBar: buildAppBar(context),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0 * pt, 36 * pt, 20 * pt, 0),
            child: Column(
              children: [
                buildSignInInput(context,
                    hintText: "$modeToString 입력해주세요",
                    onTextChange: setCredential,
                    onError: false,
                    showUnderText: false,
                    underText: "올바른 $modeToString 입력해주세요",
                    disabled: codeSended),
                SizedBox(
                  height: codeSended ? 16 : 40,
                ),
                codeSended
                    ? buildSignInInput(context,
                        hintText: "인증번호를 입력해주세요",
                        onTextChange: setVerificationCode,
                        onError: false,
                        underText: "인증번호를 받지 못하셨나요?",
                        underline: true,
                        extraUnderText: "재전송",
                        showUnderText: true,
                        onUnderTextPressed:
                            requestVerificationFactory(signInModel.method),
                        extraInputWidget: buildTimer())
                    : SizedBox(
                        height: 40,
                      ),
                codeSended
                    ? buildButtonRow()
                    : buildSigninButton(context,
                        onPressed:
                            requestVerificationFactory(signInModel.method),
                        text: "인증번호 전송")
              ],
            )));
  }

  Container buildTimer() {
    return Container(
        alignment: Alignment.center,
        height: 75,
        width: 100,
        child: Text(timeFormatter(remain),
            style: const TextStyle(
                color: const Color(0xffff3120),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 13.0),
            textAlign: TextAlign.left));
  }

  Container buildButtonRow() {
    SignInModel signInModel = Provider.of<SignInModel>(context);
    return Container(
      width: 410,
      height: 70,
      alignment: Alignment.center,
      child: Row(
        children: [
          buildSigninButton(context,
              onPressed: () => setCodeSended(false),
              text: "취소",
              textColor: const Color(0xff444444),
              borderColor: const Color(0xffbdbdbd),
              backgroundColor: const Color(0xffffffff),
              half: true),
          buildSigninButton(context, onPressed: () async {
            try {
              String _signinToken = await requestCodeVerification(
                  verificationToken, verificationCode);
              signInModel.setSigninToken(_signinToken);
              signInModel.setVerifier(credential);
            } catch (error) {
              tbShowTextDialog(context,
                  "예기치 못한 에러가 발생했습니다: ${error.toString().substring(0, 30)}...");
            }
          }, text: "확인", half: true)
        ],
      ),
    );
  }

  String timeFormatter(int timeInSec) {
    int minute = (timeInSec / 60).floor();
    int second = remain - timeInSec * 60;
    String formatter(int intToFormat) => intToFormat.toString().length == 1
        ? "0${intToFormat.toString()}"
        : intToFormat.toString();
    return "${formatter(minute)}:${formatter(second)}";
  }
}
