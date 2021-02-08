import 'package:flutter/material.dart';

class BordedButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final double radius;

  BordedButton({this.child, this.onPressed, this.radius = 10.0});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      onPressed: this.onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(this.radius),
        side: BorderSide(color: Colors.grey),
      ),
      child: this.child,
    );
  }
}
