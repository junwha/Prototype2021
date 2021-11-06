import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/utils/simple_storage/simple_storage.dart';
import 'package:prototype2021/views/login/login_view.dart';
import 'package:prototype2021/widgets/cards/flat_card.dart';
import 'package:prototype2021/widgets/shapes/circular_image.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
            "프로필",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: ScreenUtilInit(
            designSize: Size(3200, 1440),
            builder: () {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  buildProfile(context),
                  ...buildCards(),
                ],
              ));
            }));
  }

  Container buildProfile(BuildContext context) {
    UserInfoHandler infoHandler = Provider.of<UserInfoHandler>(context);
    return Container(
      child: Row(
        children: [
          CircularImage(),
          SizedBox(width: 10),
          Column(
            children: [
              Text("프로필 이름",
                  style: const TextStyle(
                      color: const Color(0xff191919),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 22.0),
                  textAlign: TextAlign.center),
              TextButton(
                onPressed: () {
                  infoHandler.setToken(null);
                  SimpleStorage.writeString(SimpleStorageKeys.jwtToken, "");
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => LoginView()),
                    (route) => false,
                  );
                },
                child: Text("로그아웃"),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
    );
  }

  List<FlatCard> buildCards() {
    return [
      FlatCard(title: '내가 쓴 글', onTap: () {}),
      FlatCard(title: '내가 만든 플랜', onTap: () {}),
    ];
  }
}
