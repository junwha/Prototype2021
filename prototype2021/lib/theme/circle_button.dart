import 'package:flutter/material.dart';

class CircleButton extends StatefulWidget {
  final bool isValueChecked;
  final Image image;
  final Function(bool) onChecked;
  CircleButton({
    this.isValueChecked = false,
    required this.onChecked,
    required this.image,
  });

  @override
  _CircleButtonState createState() =>
      _CircleButtonState(isValueChecked: isValueChecked);
}

class _CircleButtonState extends State<CircleButton> {
  bool isValueChecked;
  void setIsValueChecked(bool isChecked) => setState(() {
        isValueChecked = isChecked;
      });

  void toggleChecked() {
    setIsValueChecked(!isValueChecked);
    widget.onChecked(isValueChecked);
  }

  _CircleButtonState({required this.isValueChecked});

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
                  child: widget.image,
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
