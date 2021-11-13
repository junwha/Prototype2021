import 'package:flutter/material.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/loader/user/quit_account_loader.dart';
import 'package:prototype2021/utils/simple_storage/simple_storage.dart';
import 'package:prototype2021/views/login/login_view.dart';
import 'package:prototype2021/widgets/buttons/tb_wide_button.dart';
import 'package:provider/provider.dart';

class ConfigurationView extends StatelessWidget {
  const ConfigurationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserInfoHandler infoHandler = Provider.of<UserInfoHandler>(context);
    QuitAccountLoader quitAccountLoader = new QuitAccountLoader();
    void logout() {
      infoHandler.setToken(null);
      SimpleStorage.writeString(SimpleStorageKeys.jwtToken, "");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginView()),
        (route) => false,
      );
    }

    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: Column(
          children: [
            TBWideButton(title: "로그아웃", onTap: logout),
            TBWideButton(
                title: "회원탈퇴",
                onTap: () async {
                  await quitAccountLoader.quitAccount(infoHandler.token);
                  logout();
                }),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      centerTitle: false,
      title: Text(
        "환경설정",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
