import 'package:flutter/material.dart';

class CenterNotice extends StatelessWidget {
  final String text;
  final String? actionText;
  final void Function()? onActionPressed;

  const CenterNotice(
      {Key? key, required this.text, this.actionText, this.onActionPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildCenterNotice();
  }

  Center buildCenterNotice() {
    List<Widget> _children = [
      Text(text,
          style: const TextStyle(
              color: const Color(0xff555555),
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
              fontStyle: FontStyle.normal,
              fontSize: 18.0),
          textAlign: TextAlign.center)
    ];
    if (actionText != null) {
      _children.addAll([
        SizedBox(
          height: 5,
        ),
        TextButton(
            onPressed: onActionPressed,
            child: Text(text,
                style: const TextStyle(
                    color: const Color(0xff4080ff),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0),
                textAlign: TextAlign.center))
      ]);
    }
    return Center(
      child: Column(
        children: _children,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
