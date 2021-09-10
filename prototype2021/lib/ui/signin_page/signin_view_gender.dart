import 'package:flutter/material.dart';
import 'package:prototype2021/model/safe_http_dto/post/signup.dart';
import 'package:prototype2021/model/signin_model.dart';
import 'package:prototype2021/theme/signin/helpers.dart';
import 'package:prototype2021/theme/signin/widgets.dart';
import 'package:prototype2021/ui/signin_page/signin_view_birth.dart';
import 'package:prototype2021/ui/signin_page/signin_view_profile_main.dart';
import 'package:provider/provider.dart';

class SigninViewGender extends StatefulWidget {
  const SigninViewGender({Key? key}) : super(key: key);

  @override
  _SigninViewGenderState createState() => _SigninViewGenderState();
}

Map<Gender, String> _genderEnumStringMapping = {
  Gender.M: "남성",
  Gender.F: "여성",
  Gender.None: "선택 안함",
};

class _SigninViewGenderState extends State<SigninViewGender>
    with SignInViewWidgets, SigninViewHelper {
  Gender gender = Gender.M;
  void setGender(Gender? _gender) => setState(() {
        gender = _gender ?? Gender.None;
      });

  @override
  Widget build(BuildContext context) {
    SignInModel signInModel = Provider.of<SignInModel>(context);
    return Scaffold(
      drawerScrimColor: Colors.white,
      appBar: buildAppBar(context, shouldPopTo: SigninViewProfileMain),
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
              child: buildRadioList(),
            ),
            SizedBox(
              height: 40,
            ),
            buildSigninButton(context, onPressed: () {
              signInModel.setGender(gender);
              navigateToNext(context,
                  model: signInModel, child: SigninViewBirth());
            }, text: "다음")
          ],
        ),
      ),
    );
  }

  Column buildRadioList() {
    return Column(
      children: _genderEnumStringMapping.entries
          .map((entry) => RadioListTile(
                title: Text(
                  entry.value,
                  style: TextStyle(
                      color: Color(0xff999999),
                      fontFamily: 'Roboto',
                      fontSize: 18),
                ),
                controlAffinity: ListTileControlAffinity.trailing,
                value: entry.key,
                groupValue: gender,
                onChanged: setGender,
              ))
          .toList(),
    );
  }
}
