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
  int selectedRadio = 1;

  final _valueList = [
    '추천순',
    '별점높은순',
    '저장많은순',
    '거리가까운순',
    '최신순',
    '여행피로도낮은순',
    '여행피로도높은순',
    '여행경비낮은순',
    '여행경비높은순',
  ];
  var _selectedValue;
  final List<String> planList = [
    '당일치기',
    '2일',
    '3일',
    '4일',
    '5일',
    '6일',
    '7일~14일',
    '15일이상'
  ];
  int _counter = 0;
  bool pluscolor = true;
  bool minuscolor = true;

  void _incrementCounter() {
    setState(() {
      if (_counter < 7) {
        _counter++;
        pluscolor = true;
      } else {
        _counter = 7;
        pluscolor = false;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter == 0) {
        _counter = 0;
        minuscolor = false;
      } else {
        _counter--;
        minuscolor = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

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
              SizedBox(
                height: 10,
              ),
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
              ), // 정렬
              SizedBox(
                height: 10,
              ),
              Text("정렬",
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.left),
              Container(
                height: 60,
                width: double.infinity,
                child: DropdownButton(
                    underline: Container(
                      height: 1,
                      width: double.infinity,
                      color: const Color(0xffbdbdbd),
                    ),
                    icon: Image.asset('assets/icons/ic_arrow_down_unfold.png'),
                    isExpanded: true,
                    hint: Text('선택해주세요'),
                    value: _selectedValue,
                    items: _valueList.map((value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Row(
                            children: [
                              Image.asset('assets/icons/ic_filter_unfold.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(value),
                            ],
                          ));
                    }).toList(),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _selectedValue = value;
                      });
                    }),
              ),
              // 기간
              SizedBox(
                height: 15,
              ),

              SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("기간",
                        style: const TextStyle(
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w700,
                            fontFamily: "Roboto",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.0),
                        textAlign: TextAlign.left),
                    Row(
                      children: [
                        FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.white,
                            elevation: 0,
                            onPressed: _incrementCounter,
                            child: this.pluscolor
                                ? Image.asset(
                                    'assets/icons/button_filter_plus_black.png')
                                : Image.asset(
                                    'assets/icons/button_filter_plus_gray.png')),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          planList[_counter],
                          style: const TextStyle(
                              color: const Color(0xff707070),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.white,
                            elevation: 0,
                            onPressed: _decrementCounter,
                            child: this.minuscolor
                                ? Image.asset(
                                    'assets/icons/button_filter_minus_black.png')
                                : Image.asset(
                                    'assets/icons/button_filter_minus_gray.png')),
                      ],
                    ),
                  ]),
              SizedBox(
                height: 15,
              ),
              Text("여행 피로도",
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.left),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 1,
                    width: 210,
                    color: Color(0xffbdbdbd),
                  ),
                  ButtonBar(
                    buttonMinWidth: 300,
                    mainAxisSize: MainAxisSize.max,
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        value: 1,
                        groupValue: selectedRadio,
                        activeColor: Colors.blue,
                        onChanged: (int? val) {
                          print("Radio $val");
                          setSelectedRadio(val!);
                        },
                      ),
                      Radio(
                        value: 2,
                        groupValue: selectedRadio,
                        activeColor: Colors.blue,
                        onChanged: (int? val) {
                          print("Radio $val");
                          setSelectedRadio(val!);
                        },
                      ),
                      Radio(
                        value: 3,
                        groupValue: selectedRadio,
                        activeColor: Colors.blue,
                        onChanged: (int? val) {
                          print("Radio $val");
                          setSelectedRadio(val!);
                        },
                      ),
                      Radio(
                        value: 4,
                        groupValue: selectedRadio,
                        activeColor: Colors.blue,
                        onChanged: (int? val) {
                          print("Radio $val");
                          setSelectedRadio(val!);
                        },
                      ),
                      Radio(
                        value: 5,
                        groupValue: selectedRadio,
                        activeColor: Colors.blue,
                        onChanged: (int? val) {
                          print("Radio $val");
                          setSelectedRadio(val!);
                        },
                      ),
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
