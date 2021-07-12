import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';

class SigninView3 extends StatefulWidget {
  const SigninView3({Key? key}) : super(key: key);

  @override
  _SigninView3State createState() => _SigninView3State();
}

enum Gender { MALE, FEMALE, OTHER }

class _SigninView3State extends State<SigninView3> {
  List<bool> isChecked = [false, true];
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  Gender _genderValue = Gender.MALE;

  void _changeisChecked1(bool value) => setState(() => isChecked1 = value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white,
      appBar: buildAppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              '성별을 알려주세요.',
              style: TextStyle(
                color: Color(0xff444444),
                fontSize: 21,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: Column(
                children: [
                  RadioListTile(
                    title: const Text(
                      '남성',
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontFamily: 'Roboto',
                          fontSize: 18),
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: Gender.MALE,
                    groupValue: _genderValue,
                    onChanged: (Gender? value) {
                      setState(() {
                        _genderValue = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                      '여성',
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontFamily: 'Roboto',
                          fontSize: 18),
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: Gender.FEMALE,
                    groupValue: _genderValue,
                    onChanged: (Gender? value) {
                      setState(() {
                        _genderValue = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                      '선택안함',
                      style: TextStyle(
                          color: Color(0xff999999),
                          fontFamily: 'Roboto',
                          fontSize: 18),
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: Gender.OTHER,
                    groupValue: _genderValue,
                    onChanged: (Gender? value) {
                      setState(() {
                        _genderValue = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextButton(
                onPressed: () {},
                child: Container(
                    child: Center(
                      child: Text(
                        "다음",
                        style: const TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                      ),
                    ),
                    width: 370,
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
        title: Text("회원설정",
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 16.0 * pt),
            textAlign: TextAlign.left));
  }
}
