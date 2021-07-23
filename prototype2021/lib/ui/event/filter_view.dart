import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  bool isChecked2 = false;
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked3 = false;

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
                                    BorderRadius.all(Radius.circular(5))),
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
                                    BorderRadius.all(Radius.circular(5))),
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
                                    BorderRadius.all(Radius.circular(5))),
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
                                color: isChecked1
                                    ? Colors.blue
                                    : CupertinoColors.white,
                                border: Border.all(
                                    color: CupertinoColors.systemGrey,
                                    style: BorderStyle.solid,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
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
                                    BorderRadius.all(Radius.circular(5))),
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
                                    BorderRadius.all(Radius.circular(5))),
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
              )
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
