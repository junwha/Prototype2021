import 'package:flutter/material.dart';
import 'package:prototype2021/model/login/signin_model.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype2021/theme/pop_up.dart';
import 'package:prototype2021/theme/signin/helpers.dart';
import 'package:prototype2021/theme/signin/widgets.dart';
import 'package:prototype2021/ui/signin_page/signin_view_gender.dart';
import 'package:prototype2021/ui/signin_page/signin_view_verification.dart';
import 'package:provider/provider.dart';

class SigninViewProfileMain extends StatefulWidget {
  const SigninViewProfileMain({Key? key}) : super(key: key);

  @override
  _SigninViewProfileMainState createState() => _SigninViewProfileMainState();
}

class _SigninViewProfileMainState extends State<SigninViewProfileMain>
    with SignInViewWidgets, SigninViewHelper {
  XFile? image;
  Future<void> getImageFromGallery() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedImage;
    });
  }

  String nickname = "";
  void setNickname(String _nickname) => setState(() {
        nickname = _nickname;
      });

  TextEditingController _controller = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white,
      appBar: buildAppBar(context,
          shouldPopTo: SignInViewVerification, title: "회원 설정"),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            buildIntroduction(),
            SizedBox(
              height: 40,
            ),
            buildImagePicker(),
            buildTextInput(),
            Container(
              height: 0,
              margin: EdgeInsets.only(
                left: 87.5,
                right: 87.5,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff707070),
                  width: 1,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Column buildIntroduction() {
    return Column(
      children: [
        Text(
          '트립빌더에 오신 것을 환영합니다!',
          style: TextStyle(
            color: Color(0xff444444),
            fontSize: 21,
            fontFamily: 'Roboto',
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text('수천명의 여행 메이트와 함께하는\n나만의 간편한 여행 만들기\n지금 바로 시작하세요',
            style: TextStyle(
              color: Color(0xff999999),
              fontSize: 18,
              fontFamily: 'Roboto',
            ),
            textAlign: TextAlign.center),
      ],
    );
  }

  TextField buildTextInput() {
    return TextField(
      decoration: new InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding:
            EdgeInsets.only(left: 140, bottom: 11, top: 30, right: 50),
        hintText: "닉네임을 입력해주세요",
      ),
      onChanged: setNickname,
      maxLines: 1,
      enableInteractiveSelection: false,
      controller: _controller,
    );
  }

  Stack buildImagePicker() {
    return Stack(
      children: [
        Container(
          height: 140,
          width: 140,
          margin: EdgeInsets.only(
            left: 128,
            right: 128,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffdbdbdb),
            image: (image == null)
                ? null
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      File(image!.path),
                    ),
                  ),
          ),
        ),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            child: IconButton(
                onPressed: getImageFromGallery,
                icon: Image.asset(
                  "assets/icons/ic_image_gray.png",
                )),
          ),
          right: 110,
          bottom: 0,
        )
      ],
    );
  }

  Padding buildNextButton(BuildContext context) {
    SignInModel signInModel = Provider.of<SignInModel>(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: buildSigninButton(context, onPressed: () {
          if (image != null) signInModel.setPhoto(image!);
          if (nickname.length > 0) {
            signInModel.setNickname(nickname);
          } else {
            tbShowTextDialog(context, "닉네임을 적어주세요");
            return;
          }
          navigateToNext(context,
              model: signInModel, child: SigninViewGender());
        }, text: "다음"));
  }
}
