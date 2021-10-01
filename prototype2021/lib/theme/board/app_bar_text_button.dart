import 'package:flutter/material.dart';

class TBAppBarTextButton extends StatelessWidget {
  final Function() onPressed;
  final Image icon;
  final String text;

  TBAppBarTextButton({
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: this.onPressed,
      icon: Column(
        children: [
          this.icon,
          Text(
            this.text,
            style: TextStyle(
              color: Color(0xff555555),
              fontSize: 10,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }
}
