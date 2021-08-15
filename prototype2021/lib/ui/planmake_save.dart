import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/custom_plan_textfield.dart';
import 'package:prototype2021/theme/editor/custom_pw_textfield.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';
import 'package:prototype2021/theme/tb_contenttag.dart';
import 'package:prototype2021/theme/tb_radio_bar.dart';

class PlanmakeSaveView extends StatefulWidget {
  const PlanmakeSaveView({Key? key}) : super(key: key);

  @override
  _PlanmakeSaveViewState createState() => _PlanmakeSaveViewState();
}

class _PlanmakeSaveViewState extends State<PlanmakeSaveView> {
  int selectedRadio1 = 1;
  int selectedRadio2 = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff6f6f6),
        appBar: buildAppBar(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
            child: Row(
              children: [
                Text(
                  '여행',
                  style: TextStyle(
                    color: Color(0xff4080ff),
                    fontSize: 25,
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
                    fontSize: 19,
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
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/icons/img_check_green.png'),
                        Text(
                          '여행 피로도',
                          style: TextStyle(
                            color: Color(0xff555555),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 2,
                                width: 300,
                                color: Color(0xffbdbdbd),
                              ),
                              TBRadioBar(
                                selectedRadio: selectedRadio1,
                                onChanged: (int? val) {
                                  // Changes the selected value on 'onChanged' click on each radio button
                                  setState(() {
                                    selectedRadio1 = val!;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '여유롭고 \n느긋한 여행',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                ),
                              ), // 바쁘더라도 알찬 여행
                              Text("바쁘더라도\n알찬 여행",
                                  style: const TextStyle(
                                      color: const Color(0xff707070),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  textAlign: TextAlign.right)
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/icons/img_check_green.png'),
                        Text(
                          '여행 경비',
                          style: TextStyle(
                            color: Color(0xff555555),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 2,
                                width: 300,
                                color: Color(0xffbdbdbd),
                              ),
                              TBRadioBar(
                                selectedRadio: selectedRadio2,
                                onChanged: (int? val) {
                                  // Changes the selected value on 'onChanged' click on each radio button
                                  setState(() {
                                    selectedRadio2 = val!;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '불편해도 \n저렴하게',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                ),
                              ), // 바쁘더라도 알찬 여행
                              Text("비싸더라도\n편안하게",
                                  style: const TextStyle(
                                      color: const Color(0xff707070),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  textAlign: TextAlign.right)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Container(
                                  height: 40,
                                  width: 140,
                                  child: Center(
                                    child: Text(
                                      '저장하기',
                                      style: TextStyle(
                                        color: Color(0xff555555),
                                        fontSize: 17,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xfff6f6f6),
                                    borderRadius: BorderRadius.circular(11),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x29000000),
                                        offset: Offset(3, 3),
                                        blurRadius: 3,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
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
