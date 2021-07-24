import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked1
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked1
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked1 = !isChecked1;
                            });
                          }), // 전체
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
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked2
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked2
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked2 = !isChecked2;
                            });
                          }), // 전체
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
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked3
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked3
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked3 = !isChecked3;
                            });
                          }), // 전체
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
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked4
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked4
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked4 = !isChecked4;
                            });
                          }), // 전체
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
                  Row(
                    children: [
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked5
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked5
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked5 = !isChecked5;
                            });
                          }), // 전체
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
                  Row(
                    children: [
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked6
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked6
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked6 = !isChecked6;
                            });
                          }), // 전체
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
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked1
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked1
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked1 = !isChecked1;
                            });
                          }), // 전체
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
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked2
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked2
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked2 = !isChecked2;
                            });
                          }), // 전체
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
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked3
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked3
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked3 = !isChecked3;
                            });
                          }), // 전체
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
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked1
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked1
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked1 = !isChecked1;
                            });
                          }), // 전체
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
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked2
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked2
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked2 = !isChecked2;
                            });
                          }), // 전체
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
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked3
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked3
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked3 = !isChecked3;
                            });
                          }), // 전체
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
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked1
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked1
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked1 = !isChecked1;
                            });
                          }), // 전체
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
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked2
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked2
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked2 = !isChecked2;
                            });
                          }), // 전체
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
                      CupertinoButton(
                          child: Container(
                            decoration: BoxDecoration(
                                color: isChecked3
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            child: Icon(CupertinoIcons.check_mark,
                                size: 20,
                                color: isChecked3
                                    ? CupertinoColors.white
                                    : CupertinoColors.systemGrey),
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked3 = !isChecked3;
                            });
                          }), // 전체
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
