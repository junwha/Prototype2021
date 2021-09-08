import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/signin/widgets.dart';

class SignInViewVerification extends StatefulWidget {
  const SignInViewVerification({Key? key}) : super(key: key);

  @override
  _SignInViewVerificationState createState() => _SignInViewVerificationState();
}

class _SignInViewVerificationState extends State<SignInViewVerification>
    with SignInViewWidgets {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0 * pt, 36 * pt, 20 * pt, 0),
            child: Column(
              children: [],
            )));
  }

  Container buildButtonRow() {
    return Container(
      width: 410,
      height: 70,
      alignment: Alignment.center,
      child: Row(
        children: [
          buildSigninButton(context,
              onPressed: () {},
              text: "취소",
              textColor: const Color(0xff444444),
              borderColor: const Color(0xffbdbdbd),
              backgroundColor: const Color(0xffffffff),
              half: true),
          buildSigninButton(context, onPressed: () {}, text: "확인", half: true)
        ],
      ),
    );
  }
}
