import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  MyPageView({Key? key}) : super(key: key);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(35.0, 35.0, 35.0, 25.0),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(190)),
                      child: Image.asset('assets/icons/img_myPage_photo.png'),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        "gyuni_a",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset('assets/icons/ic_myPage_guide.png'),
                          SizedBox(
                            width: 7,
                          ),
                          Image.asset('assets/icons/ic_myPage_influencer.png')
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Text(
              "프로필 소개 입력 공간\n이정도 여백을 가져가면\n좋을 것 같아요.[추후 멘트 들어갈 예정]",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 10,
              width: double.infinity,
              color: Color.fromRGBO(244, 244, 252, 1),
            ),
            buildCard("제작한 플랜", () {}),
            buildCard("저장한 플랜 / 컨텐츠", () => null)
          ],
        ),
      ),
    );
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
