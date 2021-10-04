import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prototype2021/loader/signin/signin_loader.dart';
import 'package:prototype2021/handler/signin/signin_handler.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/widgets/dialogs/pop_up.dart';
import 'package:prototype2021/views/signin/mixin/helpers.dart';
import 'package:prototype2021/views/signin/mixin/widgets.dart';
import 'package:prototype2021/views/signin/signin_term_view.dart';
import 'package:prototype2021/views/signin/signin_view_profile_main.dart';
import 'package:provider/provider.dart';

class SignInViewVerification extends StatefulWidget {
  const SignInViewVerification({Key? key}) : super(key: key);

  @override
  _SignInViewVerificationState createState() => _SignInViewVerificationState();
}

class _SignInViewVerificationState extends State<SignInViewVerification>
    with SignInViewWidgets, SigninViewHelper, SigninLoader {
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
  bool loading = false;
  void setCodeSended(bool _codeSended) => setState(() {
        codeSended = _codeSended;
      });
  void setCredential(String _credential) => setState(() {
        credential = _credential;
      });
  void setVerificationCode(String _verificationCode) => setState(() {
        verificationCode = int.parse(_verificationCode);
      });
  void setVerificationToken(String _verificationToken) => setState(() {
        verificationToken = _verificationToken;
      });
  void setLoading(bool isLoading) => setState(() {
        loading = isLoading;
      });

  Future<void> Function() requestVerificationFactory(
      VerificationMethod method) {
    String modeToString = method == VerificationMethod.Email ? "이메일을" : "메시지를";
    String errorToString = method == VerificationMethod.Email
        ? "올바르지 않은 이메일입니다"
        : "올바르지 않은 전화번호입니다(010-xxxx-xxxx 형식으로 입력)";
    String alertMessage = "인증번호가 발송되었습니다. $modeToString 확인해주세요";
    return () async {
      setLoading(true);
      try {
        if (!validate(method)) {
          tbShowTextDialog(context, errorToString);
          return;
        }
        String _verificationToken = await requestAuth(credential, method);
        setVerificationToken(_verificationToken);
        setCodeSended(true);
        startTimer();
        tbShowTextDialog(context, alertMessage);
      } catch (error) {
        tbShowTextDialog(context, generateErrorText(error));
      }
      setLoading(false);
    };
  }

  @override
  Widget build(BuildContext context) {
    SignInHandler signInModel = Provider.of<SignInHandler>(context);
    String modeToString = signInModel.method == VerificationMethod.Email
        ? "이메일을 입력해주세요"
        : "전화번호를 입력해주세요(010-xxxx-xxxx 형식)";
    return Scaffold(
        appBar:
            buildAppBar(context, shouldPopTo: SigninTermView, title: "회원가입"),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0 * pt, 36 * pt, 20 * pt, 0),
            child: Column(
              children: [
                buildSignInInput(context, hintText: modeToString,
                    onTextChange: (String text) {
                  setCredential(text);
                },
                    onError: false,
                    showUnderText: false,
                    underText: "올바른 $modeToString 입력해주세요",
                    disabled: codeSended),
                SizedBox(
                  height: codeSended ? 16 : 40,
                ),
                codeSended
                    ? buildSignInInput(
                        context,
                        hintText: "인증번호를 입력해주세요",
                        onTextChange: setVerificationCode,
                        onError: false,
                        underText: "인증번호를 받지 못하셨나요?",
                        underline: true,
                        extraUnderText: "재전송",
                        showUnderText: true,
                        onUnderTextPressed:
                            requestVerificationFactory(signInModel.method),
                        extraInputWidget: buildTimer(),
                        loading: loading,
                      )
                    : SizedBox(
                        height: 40,
                      ),
                codeSended
                    ? buildButtonRow()
                    : buildSigninButton(
                        context,
                        onPressed:
                            requestVerificationFactory(signInModel.method),
                        text: "인증번호 전송",
                        loading: loading,
                      )
              ],
            )));
  }

  Container buildTimer() {
    return Container(
        alignment: Alignment.center,
        height: 75,
        padding: EdgeInsets.only(right: 20),
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
    SignInHandler signInModel = Provider.of<SignInHandler>(context);
    return Container(
      width: 410,
      height: 70,
      margin: EdgeInsets.only(top: 80),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSigninButton(
            context,
            onPressed: () => setCodeSended(false),
            text: "취소",
            textColor: const Color(0xff444444),
            borderColor: const Color(0xffbdbdbd),
            backgroundColor: const Color(0xffffffff),
            half: true,
            loading: loading,
          ),
          buildSigninButton(
            context,
            onPressed: () async {
              setLoading(true);
              try {
                String _signinToken = await requestCodeVerification(
                    verificationToken, verificationCode);
                signInModel.setSigninToken(_signinToken);
                signInModel.setVerifier(credential);
                navigateToNext(context,
                    model: signInModel, child: SigninViewProfileMain());
              } catch (error) {
                tbShowTextDialog(context, generateErrorText(error));
              }
              setLoading(false);
            },
            text: "확인",
            half: true,
            loading: loading,
          )
        ],
      ),
    );
  }

  bool validate(VerificationMethod method) {
    if (method == VerificationMethod.Email && validateEmail(credential)) {
      return true;
    }
    if (method == VerificationMethod.Phone && validatePhoneNumber(credential)) {
      return true;
    }
    return false;
  }

  bool validateEmail(String rawEmail) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(rawEmail)) return false;
    return true;
  }

  bool validatePhoneNumber(String rawPhoneNumber) {
    String pattern = r"^010-\d{4}-\d{4}$";
    RegExp regex = new RegExp(pattern);
    print(regex.hasMatch(rawPhoneNumber));
    if (!regex.hasMatch(rawPhoneNumber)) return false;
    return true;
  }

  String timeFormatter(int timeInSec) {
    int minute = (timeInSec / 60).floor();
    int second = remain - minute * 60;
    String formatter(int intToFormat) => intToFormat.toString().length == 1
        ? "0${intToFormat.toString()}"
        : intToFormat.toString();
    return "${formatter(minute)}:${formatter(second)}";
  }
}
