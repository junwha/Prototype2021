import 'package:flutter/material.dart';
import 'package:prototype2021/model/login/signin_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/pop_up.dart';
import 'package:prototype2021/views/signin/mixin/helpers.dart';
import 'package:prototype2021/views/signin/mixin/widgets.dart';
import 'package:prototype2021/views/signin/signin_view.dart';
import 'package:prototype2021/views/signin/signin_view_verification.dart';
import 'package:provider/provider.dart';

class SigninTermView extends StatefulWidget {
  const SigninTermView({Key? key}) : super(key: key);

  @override
  _SigninTermViewState createState() => _SigninTermViewState();
}

enum VerificationMethod { Phone, Email }

class _SigninTermViewState extends State<SigninTermView>
    with SignInViewWidgets, SigninViewHelper {
  VerificationMethod verificationMethod = VerificationMethod.Phone;
  bool firstTermChecked = false;
  bool secondTermChecked = false;
  bool thirdTermChecked = false;

  void setVerificationMethod(VerificationMethod _verificationMethod) {
    setState(() {
      verificationMethod = _verificationMethod;
    });
  }

  void Function(bool?)? setTermCheckedFactory(int number) {
    switch (number) {
      case 1:
        return (bool? isChecked) => setState(() {
              firstTermChecked = isChecked ?? false;
            });
      case 2:
        return (bool? isChecked) => setState(() {
              secondTermChecked = isChecked ?? false;
            });
      case 3:
        return (bool? isChecked) => setState(() {
              thirdTermChecked = isChecked ?? false;
            });
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white,
      appBar: buildAppBar(context, shouldPopTo: SigninView, title: "회원가입"),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0 * pt, 36 * pt, 15 * pt, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildMethodTabButton(
                  onPressed: () =>
                      setVerificationMethod(VerificationMethod.Phone),
                  isChecked: verificationMethod == VerificationMethod.Phone,
                  text: "휴대폰으로 회원가입",
                ),
                buildMethodTabButton(
                    onPressed: () =>
                        setVerificationMethod(VerificationMethod.Email),
                    isChecked: verificationMethod == VerificationMethod.Email,
                    text: "이메일로 회원가입")
              ],
            ),
            SizedBox(
              height: 75,
            ),
            buildTermCheckbox(
                isChecked: firstTermChecked,
                text: "이용약관 동의 (필수)",
                onCheckboxTap: setTermCheckedFactory(1),
                onDetailTap: () {}),
            buildTermCheckbox(
                isChecked: secondTermChecked,
                text: "개인정보취급방침 동의 (필수)",
                onCheckboxTap: setTermCheckedFactory(2),
                onDetailTap: () {}),
            buildTermCheckbox(
                isChecked: thirdTermChecked,
                text: "마케팅 수신 동의 (선택)",
                onCheckboxTap: setTermCheckedFactory(3),
                onDetailTap: () {}),
            SizedBox(
              height: 100,
            ),
            buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Row buildTermCheckbox(
      {required bool isChecked,
      required String text,
      required void Function(bool?)? onCheckboxTap,
      required void Function()? onDetailTap}) {
    return Row(
      children: [
        Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: onCheckboxTap,
            ),
            Text(
              text,
              style: TextStyle(
                color: Color(0xff444444),
                fontFamily: 'Roboto',
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        TextButton(
            onPressed: onDetailTap,
            child: Text("전체보기",
                style: TextStyle(
                  color: Color(0xff555555),
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  decoration: TextDecoration.underline,
                )))
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  TextButton buildNextButton(BuildContext context) {
    String methodToString =
        verificationMethod == VerificationMethod.Email ? "이메일" : "휴대폰";
    SignInModel signInModel = Provider.of<SignInModel>(context);
    void onPressed() {
      if (processToNext(signInModel)) {
        navigateToNext(context,
            model: signInModel, child: SignInViewVerification());
      }
    }

    return buildSigninButton(context,
        onPressed: onPressed, text: "$methodToString 인증");
  }

  OutlinedButton buildMethodTabButton(
      {required void Function() onPressed,
      required bool isChecked,
      required String text}) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
          side: MaterialStateProperty.resolveWith<BorderSide>(
              (Set<MaterialState> states) {
            final Color color = isChecked ? Color(0xff4080ff) : Colors.grey;
            return BorderSide(color: color, width: 2);
          })),
      onPressed: onPressed,
      child: Container(
        height: 55,
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 11 * pt,
              color: isChecked ? Color(0xff4080ff) : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  bool processToNext(SignInModel signInModel) {
    signInModel.setMethod(verificationMethod);
    if (firstTermChecked && secondTermChecked) {
      signInModel.setAgreeRequiredTerms(true);
    } else {
      tbShowTextDialog(context, "회원가입을 하려면 필수 약관에 동의하셔야 합니다");
      return false;
    }
    if (thirdTermChecked) {
      signInModel.setAgreeMarketingTerms(true);
    }
    return true;
  }
}
