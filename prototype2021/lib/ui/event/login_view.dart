import 'package:flutter/material.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText(),
              SizedBox(
                height: 27,
              ),
              Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xfff2f2f2),
                  ),
                  child: CustomTextField(
                    hintText: "아이디를 입력해주세요.",
                    onChanged: (String text) {},
                  )),
              SizedBox(
                height: 12,
              ),
              Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xfff2f2f2),
                  ),
                  child: CustomTextField(
                    hintText: "비밀번호를 입력해주세요.",
                    onChanged: (String text) {},
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CircleCheckButton(
                    onChecked: (bool isChecked) {
                      print(isChecked);
                    },
                  ),
                  Text("자동 로그인",
                      style: const TextStyle(
                          color: const Color(0xff555555),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 13.0),
                      textAlign: TextAlign.left),
                  SizedBox(
                    width: 10,
                  ),
                  CircleCheckButton(
                    onChecked: (bool isChecked) {
                      print(isChecked);
                    },
                  ),
                  Text("아이디 저장",
                      style: const TextStyle(
                          color: const Color(0xff555555),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 13.0),
                      textAlign: TextAlign.left),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              TextButton(
                  onPressed: () {},
                  child: Container(
                      child: Center(
                        child: Text(
                          "로그인",
                          style: const TextStyle(
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0),
                        ),
                      ),
                      width: 390,
                      height: 67,
                      decoration: BoxDecoration(
                        color: const Color(0xff4080ff),
                      ))),
              Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Image.asset("assets/icons/ic_login_kakao.png"),
                          Text("카카오 로그인",
                              style: const TextStyle(
                                  color: const Color(0xff555555),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              textAlign: TextAlign.left)
                        ],
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Image.asset("assets/icons/ic_login_naver.png"),
                          Text("네이버 로그인",
                              style: const TextStyle(
                                  color: const Color(0xff555555),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              textAlign: TextAlign.left)
                        ],
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Image.asset("assets/icons/ic_login_facebook.png"),
                          Text("페이스북 로그인",
                              style: const TextStyle(
                                  color: const Color(0xff555555),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              textAlign: TextAlign.left)
                        ],
                      ))
                ]),
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "아이디 찾기",
                        style: TextStyle(
                            color: const Color(0xff555555),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                      )),
                  Container(
                      width: 0,
                      height: 18,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xff555555), width: 1))),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "비밀번호 찾기",
                        style: TextStyle(
                            color: const Color(0xff555555),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("트립빌더가 처음이신가요?",
                      style: const TextStyle(
                          color: const Color(0xff999999),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                      textAlign: TextAlign.left),
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text("회원가입",
                              style: const TextStyle(
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0),
                              textAlign: TextAlign.left),
                          Image.asset("assets/icons/ic_small_arrow_right.png"),
                        ],
                      ))
                ],
              )
            ],
          )),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: Image.asset("asset/icons/ic_arrow_left_back.png"),
          onPressed: () {},
        ),
        title: Text("로그인",
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 15.0),
            textAlign: TextAlign.left));
  }

  Column buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 90,
        ),
        Text("쉽고 간편한 여행",
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 24.0,
                letterSpacing: 3),
            textAlign: TextAlign.left),
        SizedBox(
          height: 3,
        ),
        Text("여행이 일상이 되다",
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 24.0,
                letterSpacing: 3),
            textAlign: TextAlign.left),
        SizedBox(
          height: 3,
        ),
        Text("트립빌더",
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 24.0,
                letterSpacing: 3),
            textAlign: TextAlign.left),
      ],
    );
  }
}

class CircleCheckButton extends StatefulWidget {
  bool isValueChecked;
  Function(bool) onChecked;
  CircleCheckButton({this.isValueChecked = false, required this.onChecked});

  @override
  _CircleCheckButtonState createState() => _CircleCheckButtonState();
}

class _CircleCheckButtonState extends State<CircleCheckButton> {
  late bool _value;

  @override
  void initState() {
    _value = this.widget.isValueChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
          this.widget.onChecked(this._value);
        });
      },
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _value
              ? Container(
                  width: 21,
                  height: 21,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                      color: const Color(0xff4080ff)),
                  child: Image.asset("assets/icons/ic_check_white.png"),
                )
              : Container(
                  width: 21,
                  height: 21,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                      border:
                          Border.all(color: const Color(0xffbdbdbd), width: 1),
                      color: const Color(0xffffffff)))),
    ));
  }
}
