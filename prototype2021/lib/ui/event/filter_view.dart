import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype2021/theme/filter_checkbox.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  bool isChecked2 = false;
  bool isChecked1 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;
  bool isChecked7 = false;
  bool isChecked8 = false;
  bool isChecked9 = false;
  bool isChecked10 = false;
  bool isChecked11 = false;
  bool isChecked12 = false;
  bool isChecked13 = false;
  bool isChecked14 = false;
  bool isChecked15 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 컨텐츠 종류
              Text("컨텐츠 종류",
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.left),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked1),
                      Text("전체",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked2),
                      Text("여행지",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked3),
                      Text("카페",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked4),
                      Text("음식점",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                  Positioned(
                    left: 20,
                    child: Row(
                      children: [
                        FilterCheckBox(isChecked: isChecked5),
                        Text("숙소",
                            style: const TextStyle(
                                color: const Color(0xff707070),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            textAlign: TextAlign.left)
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked6),
                      Text("기타",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ],
              ), // 컨텐츠 테마
              Text("컨텐츠 테마",
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.left),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked7),
                      Text("역사탐방",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked8),
                      Text("맛집탐방",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked9),
                      Text("액티비티",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked10),
                      Text("야경감상",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked11),
                      Text("SNS핫플",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked12),
                      Text("휴양",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked13),
                      Text("이색체험",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked14),
                      Text("인생사진",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                  Row(
                    children: [
                      FilterCheckBox(isChecked: isChecked15),
                      Text("쇼핑메카",
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
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
        title: Text("회원가입",
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 16.0),
            textAlign: TextAlign.left));
  }
}
