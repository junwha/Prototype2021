import 'package:flutter/material.dart';
import 'package:prototype2021/handler/signin/signin_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/views/event/editor/mixin/custom_text_field.dart';
import 'package:prototype2021/widgets/notices/loading.dart';
import 'package:prototype2021/views/login/login_view.dart';
import 'package:prototype2021/views/signin/signin_term_view.dart';
import 'package:prototype2021/views/signin/signin_view.dart';
import 'package:prototype2021/views/signin/signin_view_birth.dart';
import 'package:prototype2021/views/signin/signin_view_gender.dart';
import 'package:prototype2021/views/signin/signin_view_profile_main.dart';
import 'package:prototype2021/views/signin/signin_view_verification.dart';
import 'package:provider/provider.dart';

final _shouldPopTo = <Type, Widget Function()>{
  LoginView: () => LoginView(),
  SigninView: () => SigninView(),
  SigninTermView: () => SigninTermView(),
  SignInViewVerification: () => SignInViewVerification(),
  SigninViewProfileMain: () => SigninViewProfileMain(),
  SigninViewGender: () => SigninViewGender(),
  SigninViewBirth: () => SigninViewBirth(),
};

mixin SignInViewWidgets {
  AppBar buildAppBar(BuildContext context,
      {required Type shouldPopTo, required String title}) {
    SignInModel signInModel = Provider.of<SignInModel>(context);
    return AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: Image.asset("assets/icons/ic_arrow_left_back.png"),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                        create: (_) => signInModel.inherit(),
                        child: _shouldPopTo[shouldPopTo]!())));
          },
        ),
        title: Text(title,
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 16.0 * pt),
            textAlign: TextAlign.left));
  }

  Column buildSignInInput(
    BuildContext context, {
    required String hintText,
    required void Function(String) onTextChange,
    required bool onError,
    bool loading = false,
    bool hasActionButton = false,
    String actionButtonText = "",
    bool showUnderText = false,
    bool isPasswordField = false,
    bool underline = false,
    bool disabled = false,
    String? underText,
    String? extraUnderText,
    void Function()? onActionButtonPressed,
    void Function()? onUnderTextPressed,
    Widget? extraInputWidget,
  }) {
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
                  isPasswordField: isPasswordField,
                  hintText: hintText,
                  onChanged: onTextChange,
                  onError: onError,
                  extraActionsWidget: extraInputWidget,
                  disabled: disabled,
                )),
            flex: hasActionButton ? 5 : 1,
            fit: hasActionButton ? FlexFit.loose : FlexFit.tight,
          ),
          hasActionButton
              ? Flexible(
                  child: OutlinedButton(
                    child: Container(
                      height: 75,
                      width: 30,
                      child: loading
                          ? LoadingIndicator()
                          : Center(
                              child: Text(
                                actionButtonText,
                                style: TextStyle(
                                  color: Color(0xff999999),
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                    ),
                    onPressed: loading ? null : onActionButtonPressed,
                  ),
                  flex: 1)
              : SizedBox()
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      SizedBox(
        height: 8,
      ),
      Row(
        children: [
          buildUnderTextSection(
            underText: underText,
            onError: onError,
            showUnderText: showUnderText,
            underline: underline,
            onPressed: loading ? null : onUnderTextPressed,
          ),
          buildUnderTextSection(
            underText: extraUnderText,
            onError: onError,
            showUnderText: showUnderText,
            underline: underline,
            onPressed: loading ? null : onUnderTextPressed,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
      )
    ]);
  }

  Widget buildUnderTextSection({
    required String? underText,
    bool onError = false,
    bool showUnderText = true,
    bool underline = false,
    void Function()? onPressed,
  }) {
    if (underText != null) {
      if (showUnderText || onError) {
        return buildUnderText(underText, onError, underline, onPressed);
      }
    }
    return SizedBox();
  }

  GestureDetector buildUnderText(String underText, bool onError, bool underline,
      void Function()? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        underText,
        style: TextStyle(
            color: onError ? const Color(0xffff3120) : Color(0xff999999),
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
            decoration:
                underline ? TextDecoration.underline : TextDecoration.none),
      ),
    );
  }

  TextButton buildSigninButton(
    BuildContext context, {
    required void Function()? onPressed,
    required String text,
    bool loading = false,
    bool half = false,
    double gap = 1,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
  }) {
    return TextButton(
        onPressed: loading ? null : onPressed,
        child: Container(
            child: loading
                ? LoadingIndicator()
                : Center(
                    child: Text(
                      text,
                      style: TextStyle(
                          color: textColor ?? const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0),
                    ),
                  ),
            width: half ? 160 : 400,
            height: 67,
            margin:
                half ? EdgeInsets.symmetric(horizontal: gap) : EdgeInsets.zero,
            decoration: BoxDecoration(
              color: backgroundColor ?? const Color(0xff4080ff),
              border: borderColor != null
                  ? Border.all(width: 1, color: borderColor)
                  : null,
            )));
  }
}
