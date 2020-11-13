import 'package:flutter/material.dart';

class SelectBarButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  SelectBarButton({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      onPressed: this.onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.grey)),
      child: this.child,
    );
  }
}
