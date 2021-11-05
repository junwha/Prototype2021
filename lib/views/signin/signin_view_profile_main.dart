import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prototype2021/handler/signin/signin_handler.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype2021/widgets/dialogs/pop_up.dart';
import 'package:prototype2021/views/signin/mixin/helpers.dart';
import 'package:prototype2021/views/signin/mixin/widgets.dart';
import 'package:prototype2021/views/signin/signin_view_gender.dart';
import 'package:prototype2021/views/signin/signin_view_verification.dart';
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
      resizeToAvoidBottomInset: false,
      drawerScrimColor: Colors.white,
      appBar: buildAppBar(context,
          shouldPopTo: SignInViewVerification, title: "회원 설정"),
      body: ScreenUtilInit(
          designSize: Size(3200, 1440),
          builder: () {
            return Center(
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
                  SizedBox(
                    height: 60,
                  ),
                  buildNextButton(context),
                ],
              ),
            );
          }),
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

  Container buildTextInput() {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: TextField(
            decoration: InputDecoration(
          hintText: '닉네임을 입력해주세요',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
          controller: _controller,
          maxLines: 1,
          onChanged: setNickname,
          enableInteractiveSelection: false,
          textAlign: TextAlign.center
        ),
      ),
    );
  }

  Stack buildImagePicker() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height - 700,
          width:  MediaQuery.of(context).size.width - 150,
          // margin: EdgeInsets.only(
          //   left: 128,
          //   right: 128,
          // ),
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

          left: 110,
          bottom: 0,
        )
      ],
    );
  }

  Padding buildNextButton(BuildContext context) {
    SignInHandler signInModel = Provider.of<SignInHandler>(context);
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
