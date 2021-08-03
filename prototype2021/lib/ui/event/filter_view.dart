import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype2021/theme/filter_checkbox.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  List<bool> isChecked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  int selectedRadio1 = 1;
  int selectedRadio2 = 1;

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
      if (_counter != 7) {
        _counter++;
        if (_counter == 7) {
          pluscolor = false;
        } else {
          pluscolor = true;
          minuscolor = true;
        }
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter != 0) {
        _counter--;
        if (_counter == 0) {
          minuscolor = false;
        } else {
          pluscolor = true;
          minuscolor = true;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    selectedRadio1 = 0;
    selectedRadio2 = 0;
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio1(int val) {
    setState(() {
      selectedRadio1 = val;
    });
  }

  setSelectedRadio2(int val) {
    setState(() {
      selectedRadio2 = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildMainText('컨텐츠 종류'),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCheckRow("전체", isChecked[0]),
                  buildCheckRow("여행지", isChecked[1]),
                  buildCheckRow("카페", isChecked[2]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCheckRow("음식점", isChecked[3]),
                  buildCheckRow("숙소", isChecked[4]),
                  buildCheckRow("기타", isChecked[5]),
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                buildCheckRow("역사탐방", isChecked[6]),
                buildCheckRow("맛집탐방", isChecked[7]),
                buildCheckRow("액티비티", isChecked[8]),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCheckRow("야경감상", isChecked[9]),
                  buildCheckRow("SNS핫플", isChecked[10]),
                  buildCheckRow("휴양", isChecked[11]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCheckRow("이색체험", isChecked[12]),
                  buildCheckRow("인생사진", isChecked[13]),
                  buildCheckRow("쇼핑메카", isChecked[14]),
                ],
              ), // 정렬
              SizedBox(
                height: 10,
              ),
              buildMainText("정렬"),
              buildSortContent(),
              SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildMainText("기간"),
                    buildPeriodContent(),
                  ]),
              SizedBox(
                height: 15,
              ),
              buildMainText("여행 피로도"),
              SizedBox(
                height: 20,
              ),
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
                  ButtonBar(
                    mainAxisSize: MainAxisSize.max,
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      buildRadio1(context, 1),
                      buildRadio1(context, 2),
                      buildRadio1(context, 3),
                      buildRadio1(context, 4),
                      buildRadio1(context, 5),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 9,
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
              SizedBox(
                height: 20,
              ),
              buildMainText('여행 경비'),
              SizedBox(
                height: 20,
              ),
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
                  ButtonBar(
                    mainAxisSize: MainAxisSize.max,
                    alignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      buildRadio2(context, 6),
                      buildRadio2(context, 7),
                      buildRadio2(context, 8),
                      buildRadio2(context, 9),
                      buildRadio2(context, 10),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Container buildSortContent() {
    return Container(
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
    );
  }

  Row buildPeriodContent() {
    return Row(
      children: [
        FloatingActionButton(
            mini: true,
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: _decrementCounter,
            child: this.minuscolor
                ? Image.asset('assets/icons/button_filter_minus_black.png')
                : Image.asset('assets/icons/button_filter_minus_gray.png')),
        SizedBox(
          width: 20,
        ),
        Container(
          width: 65,
          child: Center(
            child: Text(
              planList[_counter],
              style: const TextStyle(
                  color: const Color(0xff707070),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        FloatingActionButton(
            mini: true,
            backgroundColor: Colors.white,
            elevation: 0,
            onPressed: _incrementCounter,
            child: this.pluscolor
                ? Image.asset('assets/icons/button_filter_plus_black.png')
                : Image.asset('assets/icons/button_filter_plus_gray.png')),
      ],
    );
  }

  Container buildRadio1(BuildContext context, int value) {
    return Container(
      width: 30,
      height: 30,
      color: Colors.white,
      child: Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: const Color(0xffbdbdbd),
          disabledColor: Colors.blue,
          backgroundColor: Colors.white,
        ),
        child: Transform.scale(
          scale: 1.7,
          child: Radio(
            focusColor: Colors.white,
            hoverColor: Colors.white,
            value: value,
            groupValue: selectedRadio1,
            activeColor: Colors.blue,
            onChanged: (int? val) {
              print("Radio $val");
              setSelectedRadio1(val!);
            },
          ),
        ),
      ),
    );
  }

  Container buildRadio2(BuildContext context, int value) {
    return Container(
      width: 30,
      height: 30,
      color: Colors.white,
      child: Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: const Color(0xffbdbdbd),
          disabledColor: Colors.blue,
          backgroundColor: Colors.white,
        ),
        child: Transform.scale(
          scale: 1.7,
          child: Radio(
            focusColor: Colors.white,
            hoverColor: Colors.white,
            value: value,
            groupValue: selectedRadio2,
            activeColor: Colors.blue,
            onChanged: (int? val) {
              print("Radio $val");
              setSelectedRadio2(val!);
            },
          ),
        ),
      ),
    );
  }

  Row buildCheckRow(String text, bool isChecked) {
    // text는 6글자 이상 입력시 overflow발생
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: [
          FilterCheckBox(isChecked: isChecked),
          Container(
            width: 50,
            child: Text(text,
                style: const TextStyle(
                    color: const Color(0xff707070),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0),
                textAlign: TextAlign.left),
          )
        ],
      )
    ]);
  }

  Text buildMainText(String text) {
    return Text(text,
        style: const TextStyle(
            color: const Color(0xff000000),
            fontWeight: FontWeight.w700,
            fontFamily: "Roboto",
            fontStyle: FontStyle.normal,
            fontSize: 18.0),
        textAlign: TextAlign.left);
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
        title: Text("필터 화면",
            style: const TextStyle(
                color: const Color(0xff000000),
                fontWeight: FontWeight.w400,
                fontFamily: "Roboto",
                fontStyle: FontStyle.normal,
                fontSize: 16.0),
            textAlign: TextAlign.left));
  }
}
