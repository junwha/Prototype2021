import 'package:flutter/material.dart';
import 'package:prototype2021/model/login/http/login.dart';
import 'package:prototype2021/loader/user/auth_loader.dart';
import 'package:prototype2021/handler/login/login_handler.dart';
import 'package:prototype2021/handler/signin/signin_handler.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/views/board/main/board_main_view.dart';
import 'package:prototype2021/widgets/buttons/circle_button.dart';
import 'package:prototype2021/views/event/editor/mixin/custom_text_field.dart';
import 'package:prototype2021/widgets/notices/loading.dart';
import 'package:prototype2021/widgets/dialogs/pop_up.dart';
import 'package:prototype2021/views/signin/signin_view.dart';
import 'package:provider/provider.dart';
import 'package:prototype2021/settings/constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with AuthLoader {
  /* =================================/================================= */
  /* =========================STATES & METHODS========================= */
  /* =================================/================================= */

  String username = "";
  String password = "";
  bool autoLogin = false;
  bool saveId = false;
  bool loading = true;
  void setUsername(String? _username) => setState(() {
        username = _username ?? "";
      });
  void setPassword(String? _password) => setState(() {
        password = _password ?? "";
      });
  void setAutoLogin(bool _autoLogin) => setState(() {
        autoLogin = _autoLogin;
      });
  void setSaveId(bool _saveId) => setState(() {
        saveId = _saveId;
      });
  void setLoading(bool _loading) => setState(() {
        loading = _loading;
      });

  Future<void> navigateToMain(BuildContext context) async {
    await Navigator.push<MaterialPageRoute>(
      context,
      MaterialPageRoute(builder: (context) => BoardMainView()),
    );
  }

  Future<void> initialize(BuildContext context) async {
    UserInfoHandler model =
        Provider.of<UserInfoHandler>(context, listen: false);
    await model.loadToken();
    await model.loadUserId();
    setAutoLogin(await LoginHandler.loadAutoLogin());
    setSaveId(await LoginHandler.loadDoSaveId());
    setUsername(await LoginHandler.loadSavedId());
    bool isValid = await validateToken(model.token);
    bool shouldGoToNext = isValid && autoLogin;
    if (shouldGoToNext) {
      await navigateToMain(context);
    }
    setLoading(false);
  }

  Future<void> saveLocalPrefs() async {
    await LoginHandler.writeAutoLogin(autoLogin);
    await LoginHandler.writeDoSaveId(saveId);
    if (saveId && username.length > 0)
      await LoginHandler.writeSavedId(username);
  }

  Future<void> onLoginPressed() async {
    try {
      LoginOutput result = await requestToken(username, password);
      UserInfoHandler model =
          Provider.of<UserInfoHandler>(context, listen: false);
      await model.saveToken(result.token);
      await model.saveId(result.id);
      model.setToken(result.token);
      model.setId(result.id);
      saveLocalPrefs();
      navigateToMain(context);
    } catch (error) {
      tbShowDialog(
          context,
          TBSimpleDialog(
              title: '로그인 오류',
              isBackEnabled: false,
              body: Container(
                child: Text(
                  "예기치 못한 에러가 발생했습니다. 아이디와 비밀번호를 다시한번 확인해주세요: ${error.toString().substring(0, 30)}",
                  textAlign: TextAlign.center,
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
              )));
    }
  }

  /* =================================/================================= */
  /* =================CONSTRUCTORS & LIFE CYCLE METHODS================= */
  /* =================================/================================= */

  @override
  void initState() {
    super.initState();
    initialize(context);
  }

  @override
  void dispose() {
    if (!loading) saveLocalPrefs();
    super.dispose();
  }

  /* =================================/================================= */
  /* ==============================WIDGETS============================== */
  /* =================================/================================= */

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return buildLoading();
    }
    return buildLoginPage(context);
  }

  Container buildLoading() {
    return Container(
        child: LoadingIndicator(),
        decoration: new BoxDecoration(color: Colors.white));
  }

  Scaffold buildLoginPage(BuildContext context) {
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
              buildLoginButton(context),
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
        defaultValue: username,
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
    Image image = Image.asset("assets/icons/ic_check_white.png");
    return Row(
      children: [
        CircleButton(
          onChecked: setAutoLogin,
          isValueChecked: autoLogin,
          image: image,
        ),
        Text(
          "자동 로그인",
          style: textStyle,
          textAlign: TextAlign.left,
        ),
        SizedBox(width: 10),
        CircleButton(
          onChecked: setSaveId,
          isValueChecked: saveId,
          image: image,
        ),
        Text(
          "아이디 저장",
          style: textStyle,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Container buildLoginInput({
    required String hintText,
    required void Function(String) onChanged,
    String? defaultValue,
  }) {
    return Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xfff2f2f2),
        ),
        child: CustomTextField(
          hintText: hintText,
          onChanged: onChanged,
          initialText: defaultValue ?? '',
        ));
  }

  TextButton buildLoginButton(BuildContext context) {
    return TextButton(
        onPressed: onLoginPressed,
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
                          create: (_) => SignInHandler(),
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
