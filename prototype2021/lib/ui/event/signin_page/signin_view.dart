import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';
import 'package:prototype2021/theme/editor/custom_text_PW.dart';
import 'package:the_validator/the_validator.dart';

class SigninView extends StatefulWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  _SigninViewState createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0 * pt, 36 * pt, 20 * pt, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    width: 220 * pt,
                    height: 75,
                    decoration: BoxDecoration(
                      color: const Color(0xfff2f2f2),
                    ),
                    child: CustomTextField(
                        hintText: "사용할 아이디를 입력해주세요.",
                        onChanged: (String text) {})),
                SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                  child: Container(
                    height: 75,
                    width: 30,
                    child: Center(
                      child: Text(
                        "중복\n확인",
                        style: TextStyle(
                          color: Color(0xff999999),
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '영문, 숫자 조합으로 6자 이상',
              style: TextStyle(
                color: Color(0xff999999),
                fontSize: 10 * pt,
                fontFamily: 'Roboto',
                shadows: [
                  BoxShadow(
                    color: Color(0x29000000),
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
                height: 75,
                decoration: BoxDecoration(
                  color: const Color(0xfff2f2f2),
                ),
                child: CustomTextFieldPW(
                    hintText: "비밀번호를 입력해주세요.", onChanged: (String text) {})),
            SizedBox(
              height: 8,
            ),
            Text(
              '영문, 숫자 특수 문자 조합으로 8자 이상',
              style: TextStyle(
                color: Color(0xff999999),
                fontSize: 10 * pt,
                fontFamily: 'Roboto',
                shadows: [
                  BoxShadow(
                    color: Color(0x29000000),
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
                height: 75,
                decoration: BoxDecoration(
                  color: const Color(0xfff2f2f2),
                ),
                child: CustomTextFieldPW(
                    hintText: "비밀번호를 다시 입력해주세요.", onChanged: (String text) {})),
            SizedBox(
              height: 40,
            ),
            TextButton(
                onPressed: () {},
                child: Container(
                    child: Center(
                      child: Text(
                        "회원가입",
                        style: const TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                      ),
                    ),
                    width: 400,
                    height: 67,
                    decoration: BoxDecoration(
                      color: const Color(0xff4080ff),
                    ))),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: Image.asset("assets/icons/ic_arrow_left_back.png"),
          onPressed: () {},
        ),
        title: Text("회원가입",
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 16.0 * pt),
            textAlign: TextAlign.left));
  }
}
