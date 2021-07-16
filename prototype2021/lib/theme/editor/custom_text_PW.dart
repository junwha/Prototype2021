import 'package:flutter/material.dart';

class CustomTextFieldPW extends StatefulWidget {
  String hintText;
  Function(String) onChanged;
  String initialText;
  int maxLine;
  CustomTextFieldPW(
      {required this.hintText,
      required this.onChanged,
      this.initialText = '',
      this.maxLine = 1});

  @override
  _CustomTextFieldPWState createState() => _CustomTextFieldPWState();
}

class _CustomTextFieldPWState extends State<CustomTextFieldPW> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: this.widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 30, right: 15),
              hintText: this.widget.hintText),
          onChanged: this.widget.onChanged,
          obscureText: true,
          maxLines: this.widget.maxLine,
          keyboardType: TextInputType.multiline,
          enableInteractiveSelection: false,
        )
      ],
    );
  }
}
