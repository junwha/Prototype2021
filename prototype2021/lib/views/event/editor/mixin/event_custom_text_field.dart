import 'package:flutter/material.dart';

class EventCustomTextField extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;
  final String initialText;
  final int maxLine;
  final bool isPasswordField;
  final bool onError;
  final double height;

  EventCustomTextField({
    required this.hintText,
    required this.onChanged,
    required this.height,
    this.initialText = '',
    this.maxLine = 1,
    this.isPasswordField = false,
    this.onError = false,
  });

  @override
  _EventCustomTextFieldState createState() => _EventCustomTextFieldState();
}

class _EventCustomTextFieldState extends State<EventCustomTextField> {
  bool isObscure = true;
  bool isChecked2 = false;
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: this.widget.initialText);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.widget.height,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  color:
                      this.widget.onError ? Colors.white : Colors.transparent,
                  width: 1))),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 15, bottom: 11, top: 30, right: 15),
            hintText: this.widget.hintText),
        onChanged: this.widget.onChanged,
        maxLines: this.widget.maxLine,
        obscureText: this.widget.isPasswordField ? this.isObscure : false,
        keyboardType: TextInputType.multiline,
        enableInteractiveSelection: false,
      ),
    );
  }
}
