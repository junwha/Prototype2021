import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/custom_plan_textfield.dart';
import 'package:prototype2021/theme/editor/custom_pw_textfield.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';
import 'package:prototype2021/theme/tb_contenttag.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                              height: 150,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        'assets/icons/planmakeimage.png'),
                                    fit: BoxFit.fill,
                                  ))),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomPlanTextField(
                                  hintText: '여행 이름을 입력해주세요.',
                                  onChanged: (String text) {}),
                              SizedBox(
                                height: 5,
                              ),
                              Text("상하이, 베이징, 광저우",
                                  style: const TextStyle(
                                      color: const Color(0xff555555),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 11.0),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: 10,
                              ), // 기간 : 4일(1월 1일~4일)
                              Text("기간 : 4일(1월 1일~4일)",
                                  style: const TextStyle(
                                      color: const Color(0xff555555),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  textAlign: TextAlign.left),
                              CustomPlanTextField(
                                  hintText: '예산을 입력해주세요.',
                                  fontsize: 14,
                                  onChanged: (String text) {}),

                              Row(
                                children: [
                                  TBContentTag(contentTitle: '액티비티'),
                                  TBContentTag(contentTitle: 'SNS핫플'),
                                  TBContentTag(contentTitle: '휴양지'),
                                  IconButton(
                                    icon: Image.asset(
                                        "assets/icons/ic_save_edit.png"),
                                    onPressed: () {},
                                  ),
                                ],
                              )
                            ],
                          ), // 상하이, 베이징, 광저우
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Color(0xffbdbdbd),
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
