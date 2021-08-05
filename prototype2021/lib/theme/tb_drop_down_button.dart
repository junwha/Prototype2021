import 'package:flutter/material.dart';

class TBDropDownButton extends StatefulWidget {
  Function(Object?) onChanged;
  List<String> dropDownList;

  TBDropDownButton({required this.dropDownList, required this.onChanged});

  @override
  _TBDropDownButtonState createState() => _TBDropDownButtonState();
}

class _TBDropDownButtonState extends State<TBDropDownButton> {
  var selectedValue;

  @override
  Widget build(BuildContext context) {
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
          value: selectedValue,
          items: this.widget.dropDownList.map((value) {
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
          onChanged: this.widget.onChanged),
    );
  }
}
