import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            "내정보",
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
                  buildCard('임시 저장한 글', () {}),
                  buildCard('내가 쓴 글', () {}),
                  buildCard('내가 찜한 글', () {})
                ],
              ));
            }));
  }

  Container buildCard(
    String title,
    Function()? onTap,
  ) {
    return Container(
        width: double.infinity,
        height: 85,
        child: Card(
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 25, 0, 0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(68, 68, 68, 1)),
              ),
            ),
          ),
        ));
  }
}
