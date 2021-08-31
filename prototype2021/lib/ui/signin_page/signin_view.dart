import 'package:flutter/material.dart';
import 'package:prototype2021/loader/signin_loader.dart';
import 'package:prototype2021/model/signin_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';
import 'package:prototype2021/theme/pop_up.dart';

import 'package:prototype2021/ui/signin_page/signin_view_1.dart';
import 'package:provider/provider.dart';

class SigninView extends StatefulWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  _SigninViewState createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> with SigninLoader {
  String username = "";
  String password = "";
  String passwordConfirm = "";
  bool invalidUsername = false;
  bool invalidPassword = false;
  bool invalidPasswordConfirm = false;
  bool hasDuplicate = false;
  bool checkedDuplicate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0 * pt, 36 * pt, 20 * pt, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildIdInput(),
            SizedBox(
              height: 16,
            ),
            buildPasswordInput(),
            SizedBox(
              height: 16,
            ),
            buildPasswordConfirmInput(),
            SizedBox(
              height: 40,
            ),
            buildSigninButton(context),
          ],
        ),
      ),
    );
  }

  Column buildIdInput() {
    void setId(String id) {
      setState(() {
        username = id;
      });
    }

    Future<void> checkDuplicacy() async {
      try {
        bool _hasDuplicate = await checkIfIdHasDuplicate(username);
        if (_hasDuplicate) {
          _showDialog("ID가 중복되어 사용할 수 없습니다");
        } else {
          _showDialog("사용할 수 있는 아이디입니다");
        }
        setState(() {
          hasDuplicate = _hasDuplicate;
          checkedDuplicate = true;
        });
      } catch (e) {
        print(e);
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Flexible(
            child: Container(
                width: 220 * pt,
                height: 75,
                decoration: BoxDecoration(
                  color: const Color(0xfff2f2f2),
                ),
                child: CustomTextField(
                  hintText: "사용할 아이디를 입력해주세요.",
                  onChanged: setId,
                  onError: invalidUsername,
                )),
            flex: 5,
          ),
          Flexible(
              child: OutlinedButton(
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
                onPressed: checkDuplicacy,
              ),
              flex: 1)
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        '영문, 숫자 조합으로 6자 이상',
        style: TextStyle(
          color: invalidUsername ? const Color(0xffff3120) : Color(0xff999999),
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
    ]);
  }

  Column buildPasswordInput() {
    void setPassword(String pw) {
      setState(() {
        password = pw;
      });
    }

    return Column(
      children: [
        CustomTextField(
          isPasswordField: true,
          hintText: "비밀번호를 입력해주세요.",
          onChanged: setPassword,
          onError: invalidPassword,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '영문, 숫자 특수 문자 조합으로 8자 이상',
          style: TextStyle(
            color:
                invalidPassword ? const Color(0xffff3120) : Color(0xff999999),
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
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Column buildPasswordConfirmInput() {
    void setPasswordConfirm(String pwConfirm) {
      setState(() {
        passwordConfirm = pwConfirm;
      });
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomTextField(
        isPasswordField: true,
        hintText: "비밀번호를 다시 입력해주세요.",
        onChanged: setPasswordConfirm,
        onError: invalidPasswordConfirm,
      ),
      SizedBox(
        height: 8,
      ),
      invalidPasswordConfirm
          ? Text(
              '비밀번호가 일치하지 않습니다.',
              style: TextStyle(
                color: const Color(0xffff3120),
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
            )
          : SizedBox(),
    ]);
  }

  TextButton buildSigninButton(BuildContext context) {
    bool validate() {
      RegExp numericExp = RegExp(r'[0-9]+');
      RegExp alphabetExp = RegExp(r'[a-zA-Z]');
      RegExp specialCharExp = RegExp(r'[^a-zA-Z0-9]');
      if (numericExp.hasMatch(username) &&
          alphabetExp.hasMatch(username) &&
          username.length >= 6) {
        setState(() {
          invalidUsername = false;
        });
      } else {
        setState(() {
          invalidUsername = true;
        });
      }
      if (numericExp.hasMatch(password) &&
          alphabetExp.hasMatch(password) &&
          specialCharExp.hasMatch(password) &&
          password.length >= 8) {
        setState(() {
          invalidPassword = false;
        });
      } else {
        setState(() {
          invalidPassword = true;
        });
      }
      if (password == passwordConfirm) {
        setState(() {
          invalidPasswordConfirm = false;
        });
      } else {
        setState(() {
          invalidPasswordConfirm = true;
        });
      }
      if (!invalidUsername && !invalidPassword && !invalidPasswordConfirm) {
        return true; // valid form submission
      }
      if (!checkedDuplicate) {
        _showDialog("ID 중복 확인을 해주세요");
        return false;
      }
      if (hasDuplicate) {
        _showDialog("중복되지 않는 ID로 변경해주세요");
      }
      return false; // not valid form submission
    }

    SignInModel signinHandler = Provider.of<SignInModel>(context);

    return TextButton(
        onPressed: () {
          bool isValid = validate();
          if (isValid) {
            signinHandler.setCredentials(username, password);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (_) => signinHandler.inherit(),
                      child: SigninView1())),
            );
          }
        },
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
            )));
  }

  void _showDialog(String content) {
    tbShowDialog(
        context,
        TBSimpleDialog(
          title: "알림",
          body: Text(content,
              style: const TextStyle(
                  color: const Color(0xbf707070),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0),
              textAlign: TextAlign.center),
          isBackEnabled: false,
        ));
  }

  AppBar buildAppBar(BuildContext context) {
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
