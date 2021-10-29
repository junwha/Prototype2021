import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype2021/widgets/checkboxes/filter_checkbox.dart';
import 'package:prototype2021/widgets/radio/tb_radio_bar.dart';
import 'package:prototype2021/widgets/buttons/tb_plus_minus_button.dart';
import 'package:prototype2021/widgets/buttons/tb_drop_down_button.dart';

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

  @override
  void initState() {
    super.initState();
    selectedRadio1 = 0;
    selectedRadio2 = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5),
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
              TBDropDownButton(
                  dropDownList: [
                    '추천순',
                    '별점높은순',
                    '저장많은순',
                    '거리가까운순',
                    '최신순',
                    '여행피로도낮은순',
                    '여행피로도높은순',
                    '여행경비낮은순',
                    '여행경비높은순',
                  ],
                  selectedValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildMainText("기간"),
                    TBPlusMinusButton(
                      stringList: [
                        '당일치기',
                        '2일',
                        '3일',
                        '4일',
                        '5일',
                        '6일',
                        '7일~14일',
                        '15일이상'
                      ],
                    ),
                  ]),
              SizedBox(
                height: 15,
              ),
              buildMainText("여행 피로도"),
              SizedBox(
                height: 20,
              ),
              TBRadioBar(
                selectedRadio: selectedRadio1,
                onChanged: (int? val) {
                  // Changes the selected value on 'onChanged' click on each radio button
                  setState(() {
                    selectedRadio1 = val!;
                  });
                },
                minimumText: '여유롭고 \n느긋한 여행',
                maximumText: "바쁘더라도\n알찬 여행",
              ),
              SizedBox(
                height: 20,
              ),
              buildMainText('여행 경비'),
              SizedBox(
                height: 20,
              ),

              TBRadioBar(
                selectedRadio: selectedRadio2,
                onChanged: (int? val) {
                  // Changes the selected value on 'onChanged' click on each radio button
                  setState(() {
                    selectedRadio2 = val!;
                  });
                },
                minimumText: "불편해도\n 저렴하게",
                maximumText: "비싸더라도\n 편안하게",
              ),
            ],
          ),
        ));
  }

  Container buildSortContent() {
    return Container(
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
            setState(() {
              _selectedValue = value;
            });
          }),
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

  Column buildRadioArea(String title, int selectedRadio,
      Function(int?) onChanged, String minimum, String maximum) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildMainText(title),
        SizedBox(
          height: 20,
        ),
        TBRadioBar(
          selectedRadio: selectedRadio,
          onChanged: onChanged,
          minimumText: minimum,
          maximumText: maximum,
        ),
      ],
    );
  }
}
