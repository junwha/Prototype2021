import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';

mixin SignInViewWidgets {
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

  Column buildSignInInput(
    BuildContext context, {
    required String hintText,
    required void Function(String) onTextChange,
    required bool onError,
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
          ),
          hasActionButton
              ? Flexible(
                  child: OutlinedButton(
                    child: Container(
                      height: 75,
                      width: 30,
                      child: Center(
                        child: Text(
                          actionButtonText,
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                    onPressed: onActionButtonPressed,
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
              onPressed: onUnderTextPressed),
          buildUnderTextSection(
              underText: extraUnderText,
              onError: onError,
              showUnderText: showUnderText,
              underline: underline,
              onPressed: onUnderTextPressed)
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
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

  TextButton buildUnderText(String underText, bool onError, bool underline,
      void Function()? onPressed) {
    return TextButton(
        onPressed: onPressed,
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
        ));
  }

  TextButton buildSigninButton(
    BuildContext context, {
    required void Function()? onPressed,
    required String text,
    bool half = false,
    double gap = 5,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
  }) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
            child: Center(
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
            width: half ? 200 - gap : 400,
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
