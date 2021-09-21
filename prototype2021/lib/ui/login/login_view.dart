import 'package:flutter/material.dart';
import 'package:prototype2021/model/login/signin_model.dart';
import 'package:prototype2021/theme/circle_check_button.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';
import 'package:prototype2021/ui/board/board_main_view.dart';
import 'package:prototype2021/ui/signin_page/signin_view.dart';
import 'package:provider/provider.dart';
import 'package:prototype2021/settings/constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String username = "";
  String password = "";
  bool autoLogin = false;
  bool saveId = false;
  bool loading = true;
  void setUsername(String _username) => setState(() {
        username = _username;
      });
  void setPassword(String _password) => setState(() {
        password = _password;
      });
  void setAutomaticLogin(bool _autoLogin) => setState(() {
        autoLogin = _autoLogin;
      });
  void setSaveId(bool _saveId) => setState(() {
        saveId = _saveId;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70), // Top Margin
              buildMainTexts(),
              SizedBox(height: 27),
              ...buildLoginInputs(), // Spreading widgets
              SizedBox(height: 10),
              buildLoginCheckboxes(),
              SizedBox(height: 18),
              buildLoginButton(),
              buildSocialLoginButtons(),
              SizedBox(height: 60),
              buildFindIDPW(),
              buildSignin(),
            ],
          ),
        ));
  }

  List<Widget> buildLoginInputs() {
    return [
      buildLoginInput(
        hintText: "아이디를 입력해주세요.",
        onChanged: setUsername,
      ),
      SizedBox(height: 12),
      buildLoginInput(
        hintText: "비밀번호를 입력해주세요.",
        onChanged: setPassword,
      ),
    ];
  }

  Row buildLoginCheckboxes() {
    const TextStyle textStyle = const TextStyle(
      color: const Color(0xff555555),
      fontWeight: FontWeight.w400,
      fontFamily: "Roboto",
      fontStyle: FontStyle.normal,
      fontSize: 13.0 * pt,
    );
    return Row(
      children: [
        CircleCheckButton(
          onChecked: setAutomaticLogin,
        ),
        Text("자동 로그인", style: textStyle, textAlign: TextAlign.left),
        SizedBox(width: 10),
        CircleCheckButton(
          onChecked: setSaveId,
        ),
        Text("아이디 저장", style: textStyle, textAlign: TextAlign.left),
      ],
    );
  }

  Container buildLoginInput({
    required String hintText,
    required void Function(String) onChanged,
  }) {
    return Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xfff2f2f2),
        ),
        child: CustomTextField(
          hintText: hintText,
          onChanged: onChanged,
        ));
  }

  TextButton buildLoginButton() {
    return TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BoardMainView()),
          );
        },
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
            )));
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
        title: Text("로그인",
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 16.0 * pt),
            textAlign: TextAlign.left));
  }

  Column buildMainTexts() {
    const TextStyle textStyle = const TextStyle(
      color: const Color(0xff000000),
      fontWeight: FontWeight.w700,
      fontFamily: "Roboto",
      fontStyle: FontStyle.normal,
      fontSize: 22.0 * pt,
      letterSpacing: 3,
    );
    // Null stands for divider
    List<String?> texts = [
      "쉽고 간편한 여행",
      null,
      "여행이 일상이 되다",
      null,
      "트립빌더",
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: texts.map<Widget>((textOrNull) {
        // If null, return horizontal divider
        if (textOrNull == null) {
          return SizedBox(
            height: 3,
          );
        }
        // If text, render text widget
        return Text(
          textOrNull,
          style: textStyle,
          textAlign: TextAlign.left,
        );
      }).toList(),
    );
  }

  Center buildSocialLoginButtons() {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        buildSocialLoginButton(
          icon: Image.asset("assets/icons/ic_login_kakao.png"),
          text: "카카오 로그인",
          onPressed: () {},
        ),
        buildSocialLoginButton(
          icon: Image.asset("assets/icons/ic_login_naver.png"),
          text: "네이버 로그인",
          onPressed: () {},
        ),
        buildSocialLoginButton(
          icon: Image.asset("assets/icons/ic_login_facebook.png"),
          text: "페이스북 로그인",
          onPressed: () {},
        ),
      ]),
    );
  }

  TextButton buildSocialLoginButton({
    void Function()? onPressed,
    required Image icon,
    required String text,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          icon,
          Text(
            text,
            style: const TextStyle(
              color: const Color(0xff555555),
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 11.0 * pt,
            ),
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }

  Row buildFindIDPW() {
    const TextStyle textStyle = const TextStyle(
      color: const Color(0xff555555),
      fontWeight: FontWeight.w400,
      fontFamily: "Roboto",
      fontStyle: FontStyle.normal,
      fontSize: 12.0 * pt,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {},
            child: Text(
              "아이디 찾기",
              style: textStyle,
            )),
        Container(
            width: 0,
            height: 18,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff555555), width: 1))),
        TextButton(
            onPressed: () {},
            child: Text(
              "비밀번호 찾기",
              style: textStyle,
            ))
      ],
    );
  }

  Row buildSignin() {
    const TextStyle textStyle = const TextStyle(
      color: const Color(0xff999999),
      fontWeight: FontWeight.w400,
      fontFamily: "Roboto",
      fontStyle: FontStyle.normal,
      fontSize: 12.0 * pt,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "트립빌더가 처음이신가요?",
          style: textStyle,
          textAlign: TextAlign.left,
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                          create: (_) => SignInModel(),
                          child: SigninView(),
                        )),
              );
            },
            child: Row(
              children: [
                Text(
                  "회원가입",
                  style: textStyle,
                  textAlign: TextAlign.left,
                ),
                Image.asset("assets/icons/ic_small_arrow_right.png"),
              ],
            ))
      ],
    );
  }
}
