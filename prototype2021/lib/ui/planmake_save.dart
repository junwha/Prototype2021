import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/editor/custom_pw_textfield.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';

class PlanmakeSaveView extends StatefulWidget {
  const PlanmakeSaveView({Key? key}) : super(key: key);

  @override
  _PlanmakeSaveViewState createState() => _PlanmakeSaveViewState();
}

class _PlanmakeSaveViewState extends State<PlanmakeSaveView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff6f6f6),
        appBar: buildAppBar(),
        body: Column(
          children: [
            SizedBox(
              height: 130,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
              child: Row(
                children: [
                  Text(
                    '여행',
                    style: TextStyle(
                      color: Color(0xff4080ff),
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '저장하기',
                    style: TextStyle(
                      color: Color(0xff9dbeff),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)) // POINT
                    ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                              height: 140,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        'assets/icons/planmakeimage.png'),
                                    fit: BoxFit.fill,
                                  ))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
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
