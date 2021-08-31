import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype2021/model/tbdialog_model.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/custom_plan_textfield.dart';
import 'package:prototype2021/theme/editor/custom_pw_textfield.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';
import 'package:prototype2021/theme/pop_up.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';
import 'package:prototype2021/theme/tb_contenttag.dart';
import 'package:prototype2021/theme/tb_radio_bar.dart';
import 'package:prototype2021/theme/tb_save_button.dart';
import 'package:provider/provider.dart';

class PlanmakeSaveView extends StatefulWidget {
  const PlanmakeSaveView({Key? key}) : super(key: key);

  @override
  _PlanmakeSaveViewState createState() => _PlanmakeSaveViewState();
}

class _PlanmakeSaveViewState extends State<PlanmakeSaveView> {
  int selectedRadio1 = 1;
  int selectedRadio2 = 1;
  int _selectedValue = 0;
  List<String> priceList = [
    '0원~10만원',
    '10만원~30만원',
    '30만원~50만원',
    '50만원~70만원',
    '70만원~100만원',
    '100만원 이상'
  ];
  bool _selected = false;
  TBDialogModel<List<bool>> dialogModel = TBDialogModel<List<bool>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff6f6f6),
        appBar: buildAppBar(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 80,
          ),
          buildContentTitle(),
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
                        buildPreview(),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomPlanTextField(
                                  width: double.infinity,
                                  hintText: '여행 이름을 입력해주세요.',
                                  onChanged: (String text) {}),
                              SizedBox(
                                height: 5,
                              ),
                              Text("상하이, 베이징, 광저우",
                                  style: builidTextStyle(
                                      11, Color(0xff707070), FontWeight.w400),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: 10,
                              ),
                              Text("기간 : 4일(1월 1일~4일)",
                                  style: builidTextStyle(
                                      14, Color(0xff707070), FontWeight.w400),
                                  textAlign: TextAlign.left),
                              buildBudget(context),
                              Row(
                                children: [
                                  Expanded(
                                    child: Wrap(
                                      children: [
                                        TBContentTag(contentTitle: '액티비티'),
                                        TBContentTag(contentTitle: 'SNS핫플'),
                                        TBContentTag(contentTitle: '휴양지'),
                                        TBContentTag(contentTitle: '휴양지'),
                                        TBContentTag(contentTitle: '휴양지'),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      icon: Image.asset(
                                          "assets/icons/ic_save_edit.png"),
                                      onPressed: () => {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return TBSimpleDialog(
                                                  title: '태그 수정',
                                                  body: Column(
                                                    children: [
                                                      // 사각형 1720
                                                      Container(
                                                          width:
                                                              double.infinity,
                                                          height: 81,
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xfff6f6f6))),
                                                      ChangeNotifierProvider
                                                          .value(
                                                        value: dialogModel,
                                                        child: Consumer(
                                                          builder: (BuildContext
                                                                  context,
                                                              TBDialogModel<
                                                                      List<
                                                                          bool>>
                                                                  model,
                                                              child) {
                                                            return Column(
                                                              children: [],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      FilterChip(
                                                          showCheckmark: false,
                                                          selectedColor:
                                                              Colors.grey,
                                                          disabledColor:
                                                              Colors.white,
                                                          selected: _selected,
                                                          label: Text('Woolha'),
                                                          onSelected:
                                                              (bool selected) {
                                                            setState(() {
                                                              print(selected);
                                                              _selected =
                                                                  !_selected;
                                                            });
                                                          }),
                                                    ],
                                                  ),
                                                );
                                              },
                                            )
                                          }),
                                ],
                              ),
                            ],
                          ),
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
                    buildRadioArea("여행 피로도", selectedRadio1, "여유롭고\n느긋한여행",
                        "바쁘더라도\n알찬 여행"),
                    SizedBox(
                      height: 10,
                    ),
                    buildRadioArea(
                        '여행 경비', selectedRadio2, '불편해도 \n저렴하게', "비싸더라도\n편안하게"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [TBSaveButton(buttonTitle: '저장하기')],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }

  Column buildRadioArea(
      String title, int selectedRadio, String minimumText, String maximumText) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset('assets/icons/img_check_green.png'),
            Text(title,
                style: builidTextStyle(16, Color(0xff555555), FontWeight.w700)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              buildRadioButton(
                selectedRadio,
                (int? val) {
                  // Changes the selected value on 'onChanged' click on each radio button
                  setState(() {
                    selectedRadio = val!;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              buildRadioButtonTextArea(minimumText, maximumText)
            ],
          ),
        ),
      ],
    );
  }

  Container buildBudget(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "예산:",
                style: TextStyle(
                  color: Color(0xff707070),
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                priceList[_selectedValue],
                style: TextStyle(
                  color: Color(0xff707070),
                  fontFamily: 'Roboto',
                ),
              )
            ],
          ),
          IconButton(
              icon: Image.asset("assets/icons/ic_save_edit.png"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => TBSimpleDialog(
                          title: '예산설정',
                          body: Container(height: 230, child: buildCupertino()),
                        ));
              }),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Color(0xff707070)),
        ),
      ),
    );
  }

  Container buildPreview() {
    return Container(
        height: 150,
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            image: new DecorationImage(
              image: new AssetImage('assets/icons/planmakeimage.png'),
              fit: BoxFit.fill,
            )));
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

  Padding buildContentTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
      child: Row(
        children: [
          Text('여행',
              style: builidTextStyle(
                25,
                Color(0xff4080ff),
                FontWeight.w700,
              )),
          SizedBox(
            width: 6,
          ),
          Text('저장하기',
              style: builidTextStyle(19, Color(0xff9dbeff), FontWeight.w500)),
        ],
      ),
    );
  }

  TextStyle builidTextStyle(
      double size, Color textcolor, FontWeight textweight) {
    return TextStyle(
      color: textcolor,
      fontSize: size,
      fontFamily: 'Roboto',
      fontWeight: textweight,
      fontStyle: FontStyle.normal,
    );
  }

  Stack buildRadioButton(int selectedRadio, Function(int?) onChanged) {
    return Stack(
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
        TBRadioBar(selectedRadio: selectedRadio, onChanged: onChanged),
      ],
    );
  }

  Row buildRadioButtonTextArea(String Text1, String Text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(Text1,
            style: builidTextStyle(14, Color(0xff707070), FontWeight.w400)),
        Text(Text2,
            style: builidTextStyle(
              14,
              Color(0xff707070),
              FontWeight.w400,
            ),
            textAlign: TextAlign.right)
      ],
    );
  }

  CupertinoPicker buildCupertino() {
    return CupertinoPicker(
      backgroundColor: Colors.white,
      itemExtent: 45,
      scrollController: FixedExtentScrollController(initialItem: 1),
      children: priceList
          .map(
            (text) => Text(
              text,
              style: TextStyle(
                color: Color(0xff707070),
                fontFamily: 'Roboto',
              ),
            ),
          )
          .toList(),
      onSelectedItemChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
      },
    );
  }
}
