import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';

class SigninView1 extends StatefulWidget {
  const SigninView1({Key? key}) : super(key: key);

  @override
  _SigninView1State createState() => _SigninView1State();
}

class _SigninView1State extends State<SigninView1> {
  List<bool> isChecked = [false, true];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0 * pt, 36 * pt, 15 * pt, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0))),
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                          (Set<MaterialState> states) {
                        final Color color =
                            isChecked[1] ? Color(0xff4080ff) : Colors.grey;
                        return BorderSide(color: color, width: 2);
                      })),
                  onPressed: () {
                    setState(() {
                      isChecked[0] = false;
                      isChecked[1] = true;
                    });
                  },
                  child: Container(
                    height: 55,
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Center(
                      child: Text(
                        "휴대폰으로 회원가입",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 11 * pt,
                          color: isChecked[1] ? Color(0xff4080ff) : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0))),
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                          (Set<MaterialState> states) {
                        final Color color =
                            isChecked[0] ? Color(0xff4080ff) : Colors.grey;
                        return BorderSide(color: color, width: 2);
                      })),
                  onPressed: () {
                    setState(() {
                      isChecked[0] = true;
                      isChecked[1] = false;
                    });
                  },
                  child: Container(
                    height: 55,
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Center(
                      child: Text(
                        "이메일로 회원가입",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 11 * pt,
                          color: isChecked[0] ? Color(0xff4080ff) : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 75,
            ),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) => isChecked,
                ),
                Text(
                  '이용약관 동의 (필수)',
                  style: TextStyle(
                    color: Color(0xff444444),
                    fontFamily: 'Roboto',
                  ),
                )
              ],
            )
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
