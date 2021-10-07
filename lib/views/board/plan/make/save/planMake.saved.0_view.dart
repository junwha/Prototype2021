import 'package:flutter/material.dart';
import 'package:prototype2021/views/board/main/board_main_view.dart';
import 'package:prototype2021/views/board/plan/make/plan_make_view.dart';

class PlanSavedView extends StatefulWidget {
  final void Function(Navigate, [PlanMakeViewMode?]) navigator;
  PlanSavedView({Key? key, required this.navigator}) : super(key: key);

  @override
  _PlanSavedViewState createState() =>
      _PlanSavedViewState(navigator: navigator);
}

class _PlanSavedViewState extends State<PlanSavedView> {
  final void Function(Navigate, [PlanMakeViewMode?]) navigator;

  _PlanSavedViewState({required this.navigator});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Color(0xfff6f6f6),
        body: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Image.asset('assets/icons/img_tripbuilder_big.png'),
            SizedBox(
              height: 20,
            ),
            Text(
              '저장 완료',
              style: TextStyle(
                color: Color(0xff34659d),
                fontSize: 30,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '000님,\n',
                          style: TextStyle(
                            height: 1.5,
                            color: Colors.black,
                            fontSize: 26,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        TextSpan(
                          text: '플랜 저장을 완료하셨어요.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '저장한 플랜은 ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        TextSpan(
                          text: '마이 플랜',
                          style: TextStyle(
                            color: Color(0xff0055ff),
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: '에서 확인할 수 있어요.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    '다른 여행자들이 참고할 수 있도록 제작한 플랜을\n플랜게시판에 공유해주세요!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildMyPlanButton(),
                      buildShareButton(),
                    ],
                  )
                ],
              ),
              color: Colors.white,
            ))
          ],
        ));
  }

  TextButton buildMyPlanButton() {
    return TextButton(
      onPressed: () {},
      child: Container(
        child: Center(
          child: Text(
            '마이 플랜',
            style: TextStyle(
              color: Color(0xff707070),
              fontSize: 17,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        height: 60,
        width: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xffbdbdbd), width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  TextButton buildShareButton() {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => BoardMainView()));
        },
        child: Container(
            child: Center(
              child: Text(
                '플랜게시판에\n공유하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            width: 130,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: const Color(0xff4080ff))));
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xfff6f6f6),
      shadowColor: Color(0xfff6f6f6),
      elevation: 0,
      centerTitle: false,
      leading: IconButton(
        icon: Image.asset("assets/icons/ic_arrow_left_back.png"),
        onPressed: () {},
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/ic_hamburger_menu.png')),
      ],
    );
  }
}
