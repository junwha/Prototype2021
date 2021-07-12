import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';

class SigninView4 extends StatefulWidget {
  const SigninView4({Key? key}) : super(key: key);

  @override
  _SigninView4State createState() => _SigninView4State();
}

class _SigninView4State extends State<SigninView4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white,
      appBar: buildAppBar(),
      body: Center(
          child: Column(children: [
        SizedBox(
          height: 60,
        ),
        Text(
          '생년월일을 알려주세요.',
          style: TextStyle(
            color: Color(0xff444444),
            fontSize: 21,
            fontFamily: 'Roboto',
          ),
        ),
        SizedBox(
          height: 40,
        ),
      ])),
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
