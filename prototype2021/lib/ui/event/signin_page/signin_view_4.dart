import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/editor/custom_text_field.dart';
import 'package:prototype2021/theme/selectable_text_button.dart';

class SigninView4 extends StatefulWidget {
  const SigninView4({Key? key}) : super(key: key);

  @override
  _SigninView4State createState() => _SigninView4State();
}

class _SigninView4State extends State<SigninView4> {
  int startAge = 1999;
  String startMonth = '1월';
  int startDay = 1;
  final List<int> dayList = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  ];
  final List<String> monthList = [
    '1월',
    '2월',
    '3월',
    '4월',
    '5월',
    '6월',
    '7월',
    '8월',
    '9월',
    '10월',
    '11월',
    '12월'
  ];
  final List<int> ageList = [
    1990,
    1991,
    1992,
    1993,
    1994,
    1995,
    1996,
    1997,
    1998,
    1999,
    2000,
    2001,
    2002,
    2003,
    2004,
    2005,
    2006,
    2007,
    2008,
    2009,
    2010
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.white,
      appBar: buildAppBar(),
      body: Center(
          child: Column(children: [
        SizedBox(
          height: 60,
        ),
        Text(
          '생년월일을 알려주세요.',
          style: TextStyle(
            color: Color(0xff444444),
            fontSize: 21,
            fontFamily: 'Roboto',
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '생년월일',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff999999),
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffbdbdbd),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: 60,
                    width: 120,
                    child: Center(
                      child: DropdownButton<int>(
                        value: startAge,
                        isExpanded: true,
                        underline: SizedBox(),
                        items: ageList.map(
                          (value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text("$value"),
                            );
                          },
                        ).toList(),
                        onChanged: (int? value) {
                          setState(() {
                            startAge = value == null ? 0 : value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffbdbdbd),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: 60,
                    width: 120,
                    child: Center(
                      child: DropdownButton<String>(
                        value: startMonth,
                        isExpanded: true,
                        underline: SizedBox(),
                        items: monthList.map(
                          (value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text("$value"),
                            );
                          },
                        ).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            startMonth = value == null ? '1월' : value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffbdbdbd),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: 60,
                    width: 120,
                    child: Center(
                      child: DropdownButton<int>(
                        value: startDay,
                        isExpanded: true,
                        underline: SizedBox(),
                        items: dayList.map(
                          (value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text("$value"),
                            );
                          },
                        ).toList(),
                        onChanged: (int? value) {
                          setState(() {
                            startDay = value == null ? 1 : value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ])),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          icon: Image.asset("assets/icons/ic_arrow_left_back.png"),
          onPressed: () {},
        ),
        title: Text("회원설정",
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 16.0 * pt),
            textAlign: TextAlign.left));
  }
}
