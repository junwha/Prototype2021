import 'package:flutter/material.dart';

class TBRoundedTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color color;
  final Color backgroundColor;
  final double? width;
  final double height;

  const TBRoundedTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = const Color(0xffffffff),
    this.backgroundColor = const Color(0xff4080ff),
    this.height = 60,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(text,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 13.0),
              textAlign: TextAlign.center),
        ));
  }
}
