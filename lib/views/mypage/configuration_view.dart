import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/loader/board/plan_loader.dart';
import 'package:prototype2021/model/board/contents/content_type.dart';
import 'package:prototype2021/utils/logger/logger.dart';
import 'package:prototype2021/utils/simple_storage/simple_storage.dart';
import 'package:prototype2021/views/board/base/board.dart';
import 'package:prototype2021/views/login/login_view.dart';
import 'package:provider/provider.dart';

class ConfigurationView extends StatelessWidget {
  const ConfigurationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserInfoHandler infoHandler = Provider.of<UserInfoHandler>(context);
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('환경설정',style: TextStyle(fontSize: 15),),
      ),
      body: Center(

        child: (Column(
          children: [
          SizedBox(
          width: 70.0,
          height: 70.0,)
            ,
            Column(
              children: [
                  SizedBox(
                    height: 60,
                    width: 330,
                    child:
                    TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                      onPressed: () {
                        infoHandler.setToken(null);
                        SimpleStorage.writeString(SimpleStorageKeys.jwtToken, "");
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => LoginView()),
                              (route) => false,
                        );
                      },
                      child: Text("로그아웃", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color : Colors.black),),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                // SizedBox(
                //   height: 60,
                //   width: 330,
                //   child:
                //   TextButton(
                //     style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                //     onPressed: () {
                //       infoHandler.setToken(null);
                //       SimpleStorage.writeString(SimpleStorageKeys.jwtToken, "");
                //       Navigator.of(context).pushAndRemoveUntil(
                //         MaterialPageRoute(builder: (_) => LoginView()),
                //             (route) => false,
                //       );
                //     },
                //     child: Text("회원탈퇴", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color : Colors.black),),
                //   ),
                // )
              ],
            )

          ],
        )
        ),
      ),

      );
  }
}




