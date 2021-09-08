import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/ui/signin_page/signin_view_2.dart';

class SigninView1 extends StatefulWidget {
  const SigninView1({Key? key}) : super(key: key);

  @override
  _SigninView1State createState() => _SigninView1State();
}

class _SigninView1State extends State<SigninView1> {
  List<bool> isChecked = [false, true];
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  void _changeisChecked1(bool value) => setState(() => isChecked1 = value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white,
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
                  value: isChecked1,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked1 = value!;
                    });
                  },
                ),
                Text(
                  '이용약관 동의 (필수)',
                  style: TextStyle(
                    color: Color(0xff444444),
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(
                  width: 140,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text("전체보기",
                        style: TextStyle(
                          color: Color(0xff555555),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          decoration: TextDecoration.underline,
                        )))
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: isChecked2,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked2 = value!;
                    });
                  },
                ),
                Text(
                  '개인정보취급방침 동의 (필수)',
                  style: TextStyle(
                    color: Color(0xff444444),
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(
                  width: 93,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text("전체보기",
                        style: TextStyle(
                          color: Color(0xff555555),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          decoration: TextDecoration.underline,
                        )))
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: isChecked3,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked3 = value!;
                    });
                  },
                ),
                Text(
                  '마케팅 수신 동의 (선택)',
                  style: TextStyle(
                    color: Color(0xff444444),
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(
                  width: 125,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text("전체보기",
                        style: TextStyle(
                          color: Color(0xff555555),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          decoration: TextDecoration.underline,
                        ))),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SigninView2()),
                  );
                },
                child: Container(
                    child: Center(
                      child: Text(
                        "휴대폰 인증",
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
          onPressed: () {
            Navigator.pop(context);
          },
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
