import 'package:flutter/material.dart';

class CircleCheckButton extends StatefulWidget {
  final bool isValueChecked;
  final Function(bool) onChecked;
  CircleCheckButton({this.isValueChecked = false, required this.onChecked});

  @override
  _CircleCheckButtonState createState() =>
      _CircleCheckButtonState(isValueChecked: isValueChecked);
}

class _CircleCheckButtonState extends State<CircleCheckButton> {
  bool isValueChecked;
  void setIsValueChecked(bool isChecked) => setState(() {
        isValueChecked = isChecked;
      });

  void toggleChecked() {
    setIsValueChecked(!isValueChecked);
    widget.onChecked(isValueChecked);
  }

  _CircleCheckButtonState({required this.isValueChecked});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: toggleChecked,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: isValueChecked
              ? Container(
                  width: 21,
                  height: 21,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                    color: const Color(0xff4080ff),
                  ),
                  child: Image.asset("assets/icons/ic_check_white.png"),
                )
              : Container(
                  width: 21,
                  height: 21,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                    border:
                        Border.all(color: const Color(0xffbdbdbd), width: 1),
                    color: const Color(0xffffffff),
                  ),
                )),
    ));
  }
}
