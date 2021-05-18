import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';

class CheckBoxWidget extends StatefulWidget {
  bool isChecked1 = false;
  bool isChecked2 = false;
  Function(String, String, String, String, String) onChanged = (recruitNumber,
      maleRecruitNumber, femaleRecruitNumber, startAge, endAge) {};
  CheckBoxWidget(bool isChecked1, bool isChecked2,
      Function(String, String, String, String, String) onChanged) {
    this.isChecked1 = isChecked1;
    this.isChecked2 = isChecked2;
    this.onChanged = onChanged;
  }

  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  final List<String> recruitValues = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  final List<String> ageValues = [
    '0',
    '10',
    '20',
    '30',
    '40',
    '50',
    '60',
    '70',
    '80',
    '90',
  ];
  String recruitNumber = '0';
  String maleRecruitNumber = '0';
  String femaleRecruitNumber = '0';
  String startAge = '0';
  String endAge = '0';

  void updateFields() {
    this.widget.onChanged(recruitNumber, maleRecruitNumber, femaleRecruitNumber,
        startAge, endAge);
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.isChecked1 && this.widget.isChecked2) {
      return Text("");
    } else if (this.widget.isChecked1) {
      return Column(
        children: [
          buildRecruitmentNumber(),
          buildAgeSelection(),
        ],
      );
    } else if (this.widget.isChecked2) {
      return Column(
        children: [
          buildGenderRecruitment(),
        ],
      );
    } else {
      return Column(
        children: [
          buildGenderRecruitment(),
          buildAgeSelection(),
        ],
      );
    }
  }

  Widget buildGenderRecruitment() {
    return Row(
      children: [
        Text("모집인원", style: TextStyle(fontSize: 13 * pt)),
        SizedBox(
          width: 40,
        ),
        Text("남", style: TextStyle(fontSize: 13 * pt)),
        SizedBox(
          width: 10 * pt,
        ),
        DropdownButton(
          value: maleRecruitNumber,
          items: recruitValues.map(
            (value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          onChanged: (String? value) {
            setState(() {
              maleRecruitNumber = value == null ? "" : value;
              updateFields();
            });
          },
        ),
        Text("명", style: TextStyle(fontSize: 13 * pt)),
        SizedBox(
          width: 20 * pt,
        ),
        Text("여", style: TextStyle(fontSize: 13 * pt)),
        SizedBox(
          width: 10 * pt,
        ),
        DropdownButton(
          value: femaleRecruitNumber,
          items: recruitValues.map(
            (value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          onChanged: (String? value) {
            setState(() {
              femaleRecruitNumber = value == null ? "" : value;
              updateFields();
            });
          },
        ),
        Text("명", style: TextStyle(fontSize: 13 * pt))
      ],
    );
  }

  Widget buildAgeSelection() {
    return Row(
      children: [
        Text("나이", style: TextStyle(fontSize: 13 * pt)),
        SizedBox(
          width: 80,
        ),
        DropdownButton(
          value: startAge,
          items: ageValues.map(
            (value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          onChanged: (String? value) {
            setState(() {
              startAge = value == null ? "" : value;
              updateFields();
            });
          },
        ),
        Text("     ~     "),
        DropdownButton(
          value: endAge,
          items: ageValues.map(
            (value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          onChanged: (String? value) {
            setState(() {
              endAge = value == null ? "" : value;
              updateFields();
            });
          },
        ),
        Text("살", style: TextStyle(fontSize: 13 * pt))
      ],
    );
  }

  Widget buildRecruitmentNumber() {
    return Row(children: [
      Text("모집인원", style: TextStyle(fontSize: 13 * pt)),
      SizedBox(
        width: 50,
      ),
      Row(
        children: [
          DropdownButton(
            value: recruitNumber,
            items: recruitValues.map(
              (value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            onChanged: (String? value) {
              setState(() {
                recruitNumber = value == null ? "" : value;
                updateFields();
              });
            },
          ),
          Text("명", style: TextStyle(fontSize: 13 * pt))
        ],
      ),
    ]);
  }
}
